#該程式未解開Section, 採用最新樣板產出!
{<section id="afap200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0032(2017-02-07 17:38:58), PR版次:0032(2017-02-09 10:24:28)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000465
#+ Filename...: afap200
#+ Description: 固定資產/底稿產生作業
#+ Creator....: 01531(2014-02-21 13:49:44)
#+ Modifier...: 01531 -SD/PR- 01531
 
{</section>}
 
{<section id="afap200.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#150731-00004#1  by yangtt 20150807       錯誤信息匯總報錯，將舊的報錯方式(cl_errmdg)改成新的報錯方式
#151008-00017#2  by albireo 151012        (走在建工程時)固資相關參數說明無底稿編號自動編碼的描述,且底稿設置的自動編碼與固資號碼相同造成跳號,
#                                         故修改取消底稿編號的自動編碼
#151013-00019#3  2015/10/16 By Reanna     無法產生
#151023          151023     By albireo    帳款單號採購單號收貨單號帶值
#151105-00001#3  151109     By Jessy      由應付帳款單拋轉至固資時,將產品編號拋至"規格型號",品名規格拋至"名稱"
#151008-00017#3  151222     By albireo    取消#151008-00017#2之修改,改以輔導面解內容如下:若設定自動編碼者,仍可開放自動編碼，但建議另製一組底稿使用的編碼原則。
#                                         原因為可多底稿彙組一筆固資財產，財產編號應在底稿生成財產時才正式編列。 因此生成底稿時,另一組流水編號管理底稿即可
#151225-00014#1  151230     By albireo    直接產生afai100時, 取得日期應該要=AP的單據日期
#160111          160111     By albireo    連續自動編碼優化,修正只用最後一次登打的編碼原則編碼的問題
#151225-00014#2  160130     By albireo    連續自動編碼優化跟著元件修正
#160324-00036#1  160329     By 07673      bug 修改
#160318-00025#5  160414     By 07675      將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160408-00020#3  2016/04/21 By 01531      预设值为afai020里面主要类型的投资抵减值,抵减率,抵减年限
#160727-00019#1  2016/07/27 By 08742      系统中定义的临时表名称超过15码在执行时会出错,所以将系统中定义的临时表长度超过15码的全部改掉	
#160905-00007#1  2016-09-05 By 08734      ent调整
#160913-00017#1  2016/09/19 By 07900      AFA模组调整交易客商开窗
#160930-00036#1  2016/09/30 By dorishsu   1.修正產生到afai120每筆卡片編號都一樣的問題2.修正產生到afai120財產編號有&&&&的問題
#160930-00018#1  2016/10/10 By 02114      单头QBE 选项的【单据号码】开窗未排除“未审核”的资料
#161009-00006#4  2016/10/13 By 02114      卡编自动编码时，抓取max（卡编）要按归属法人来抓
#161024-00008#1  2016/10/24 By Hans       AFA組織類型與職能開窗清單調整。
#161028-00023#1  2016/10/28 By 02114      账款客户开窗应开出厂商或交易对象的资料
#161019-00042#1  2016/11/4  By 07900      单身增加摘要字段
#161111-00028#6  2016/11/17 by 06189      标准程式定义采用宣告模式,弃用.*写法
#161117-00045#1  2016/11/18 By 01727      執行分割,會出現-391的錯誤訊息
#161125-00017#1  2016/11/25 By 01531      固定資產底稿產生_1.開窗未分據點2.編碼問題
#161129-00048#1  2016/12/01 By 02599      faaj048默认取值faal006
#160923-00015#4  2016/12/07 By 07900      生成底稿时，Grid中的财产编号改为显示‘底稿编号’，顾问反应会造成误解。
#161208-00052#1  2016/12/09 By 02114      勾选生成财产底稿(在建工程、多笔财产合并分割形式者)时,执行报错"无法将NULL值插入表格"
#161221-00072#1  2016/12/22 By 02114      抓取汇率时,使用来源单据的日期抓取
#161223-00055#1  2016/12/23 By 02114      开始折旧年月的计算方式,参照afai100的计算逻辑,补上faal005为2、3、4的逻辑
#160426-00014#15 2017/01/20 By 01531      存貨轉資產: 雜發單增加轉固定資產功能 
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
       fabgsite LIKE type_t.chr10, 
   fabgsite_desc LIKE type_t.chr80, 
   ooef001 LIKE ooef_t.ooef001, 
   ooef001_desc LIKE type_t.chr80, 
   glaald LIKE type_t.chr5, 
   glaald_desc LIKE type_t.chr80, 
   f LIKE type_t.chr500, 
   apca004 LIKE type_t.chr10, 
   apcadocno LIKE type_t.chr20, 
   apcadocdt LIKE type_t.dat, 
   a LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#單頭 type 宣告

#單身 type 宣告
 TYPE type_g_apcb_d RECORD
   b LIKE type_t.chr1, 
   apcbld    LIKE apcb_t.apcbld,
   apcbld_desc LIKE type_t.chr80,
   apcbdocno LIKE apcb_t.apcbdocno,
   apcbseq  LIKE apcb_t.apcbseq,
   apcadocdt LIKE apca_t.apcadocdt, 
   apca004 LIKE apca_t.apca004,
   apca004_desc LIKE type_t.chr80,
   apca100 LIKE apca_t.apca100,
   apcb004 LIKE apcb_t.apcb004,
   apcb005 LIKE apcb_t.apcb005,
   imaal004 LIKE imaal_t.imaal004, #160426-00014#15 add
   inbb010 LIKE inbb_t.inbb010,    #160426-00014#15 add
   oocal003 LIKE oocal_t.oocal003, #160426-00014#15 add
   apcb007 LIKE apcb_t.apcb007,
   xccc280  LIKE xccc_t.xccc280,   #160426-00014#15 add
   xccc280_inbb011 LIKE xccc_t.xccc280, #160426-00014#15 add   
   apcb103 LIKE apcb_t.apcb103,
   apcb105 LIKE apcb_t.apcb105,
   apcb113 LIKE apcb_t.apcb113,
   apcb115 LIKE apcb_t.apcb115, 
   apcb015 LIKE apcb_t.apcb015,  
   apcb016 LIKE apcb_t.apcb016,
   apcb047 LIKE apcb_t.apcb047,  #161019-00042#1 add 
   t LIKE type_t.chr80,
   faah002 LIKE faah_t.faah002,
   faah001 LIKE faah_t.faah001,
   faah003 LIKE faah_t.faah003,
   faah004 LIKE faah_t.faah004,
   faah006 LIKE faah_t.faah006,
   faah007 LIKE faah_t.faah007,
   faah027 LIKE faah_t.faah027,
   c LIKE type_t.chr1,
   #albireo 160111-----s   #自動編碼必要資訊
   l_oofg001_t1   LIKE type_t.chr100,   #編碼類型
   l_before_code  LIKE type_t.chr100,   #前編碼
   l_num_code     LIKE type_t.chr100,   #流水號編碼
   l_after_code   LIKE type_t.chr100    #後編碼
   #albireo 160111-----e
END RECORD

TYPE type_g_apcb1_d RECORD
   check LIKE type_t.chr1, 
   apcald_1 LIKE apca_t.apcald,
   apcald_desc_1 LIKE type_t.chr80,   
   apcbdocno_1 LIKE apcb_t.apcbdocno,
   apcbseq_1  LIKE apcb_t.apcbseq,
   apcadocdt_1 LIKE apca_t.apcadocdt, 
   apca004_1 LIKE apca_t.apca004,
   apca004_desc_1 LIKE type_t.chr80,
   apca100_1 LIKE apca_t.apca100,
   apcb004_1 LIKE apcb_t.apcb004,
   apcb005_1 LIKE apcb_t.apcb005,
   imaal004_1 LIKE imaal_t.imaal004, #160426-00014#15 add
   apcb103_1 LIKE apcb_t.apcb103,
   apcb105_1 LIKE apcb_t.apcb105,
   apcb113_1 LIKE apcb_t.apcb113,
   apcb115_1 LIKE apcb_t.apcb115
END RECORD

DEFINE g_apcb_d              DYNAMIC ARRAY OF type_g_apcb_d 
DEFINE g_apcb1_d             DYNAMIC ARRAY OF type_g_apcb1_d 
DEFINE g_apcb_d_t            type_g_apcb_d 
DEFINE g_tmp                 type_g_apcb1_d   
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
#DEFINE g_faak               RECORD LIKE faak_t.*
#DEFINE g_faah               RECORD LIKE faah_t.*
#DEFINE g_faaj               RECORD LIKE faaj_t.*
#mark by geza 20161121 #161111-00028#6(E)
#add by geza 20161121 #161111-00028#6(S)
DEFINE g_faak RECORD  #固定資產底稿資料檔
       faakent LIKE faak_t.faakent, #企业编号
       faakld LIKE faak_t.faakld, #账套别编码
       faak000 LIKE faak_t.faak000, #生成批号
       faak001 LIKE faak_t.faak001, #卡片编号
       faak002 LIKE faak_t.faak002, #型态
       faak003 LIKE faak_t.faak003, #底稿编号
       faak004 LIKE faak_t.faak004, #附号
       faak005 LIKE faak_t.faak005, #资产性质
       faak006 LIKE faak_t.faak006, #资产主要类型
       faak007 LIKE faak_t.faak007, #资产次要类型
       faak008 LIKE faak_t.faak008, #资产组
       faak009 LIKE faak_t.faak009, #供应供应商
       faak010 LIKE faak_t.faak010, #制造供应商
       faak011 LIKE faak_t.faak011, #产地
       faak012 LIKE faak_t.faak012, #名称
       faak013 LIKE faak_t.faak013, #规格型号
       faak014 LIKE faak_t.faak014, #取得日期
       faak015 LIKE faak_t.faak015, #资产状态
       faak016 LIKE faak_t.faak016, #取得方式
       faak017 LIKE faak_t.faak017, #单位
       faak018 LIKE faak_t.faak018, #数量
       faak019 LIKE faak_t.faak019, #币种
       faak020 LIKE faak_t.faak020, #汇率
       faak021 LIKE faak_t.faak021, #原币单价
       faak022 LIKE faak_t.faak022, #原币金额
       faak023 LIKE faak_t.faak023, #本币单价
       faak024 LIKE faak_t.faak024, #本币金额
       faak025 LIKE faak_t.faak025, #保管人员
       faak026 LIKE faak_t.faak026, #保管部门
       faak027 LIKE faak_t.faak027, #存放位置
       faak028 LIKE faak_t.faak028, #存放组织
       faak029 LIKE faak_t.faak029, #负责人员
       faak030 LIKE faak_t.faak030, #管理组织
       faak031 LIKE faak_t.faak031, #核算组织
       faak032 LIKE faak_t.faak032, #归属法人
       faak033 LIKE faak_t.faak033, #直接资本化
       faak034 LIKE faak_t.faak034, #入账日期
       faak035 LIKE faak_t.faak035, #保税
       faak036 LIKE faak_t.faak036, #保险
       faak037 LIKE faak_t.faak037, #免税
       faak038 LIKE faak_t.faak038, #抵押
       faak039 LIKE faak_t.faak039, #采购单号
       faak040 LIKE faak_t.faak040, #收货单号
       faak041 LIKE faak_t.faak041, #账款单号
       faak042 LIKE faak_t.faak042, #来源营运中心
       faak043 LIKE faak_t.faak043, #更新码
       faak044 LIKE faak_t.faak044, #账款编号项次
       faak045 LIKE faak_t.faak045, #杂发单号项次
       faak046 LIKE faak_t.faak046, #资产来源
       faak047 LIKE faak_t.faak047, #杂发单号
       faak048 LIKE faak_t.faak048, #凭证单号
       faak049 LIKE faak_t.faak049, #资产属性
       faak050 LIKE faak_t.faak050, #项目编号
       faak051 LIKE faak_t.faak051, #WBS
       faakownid LIKE faak_t.faakownid, #资料所有者
       faakowndp LIKE faak_t.faakowndp, #资料所有部门
       faakcrtid LIKE faak_t.faakcrtid, #资料录入者
       faakcrtdp LIKE faak_t.faakcrtdp, #资料录入部门
       faakcrtdt LIKE faak_t.faakcrtdt, #资料创建日
       faakmodid LIKE faak_t.faakmodid, #资料更改者
       faakmoddt LIKE faak_t.faakmoddt, #最近更改日
       faakstus LIKE faak_t.faakstus, #状态码
       faak052 LIKE faak_t.faak052, #抵减率
       faak053 LIKE faak_t.faak053, #投资抵减
       faak054 LIKE faak_t.faak054 #投资抵减年限
END RECORD
DEFINE g_faah RECORD  #固定資產基礎資料檔
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
       faah056 LIKE faah_t.faah056, #免税状态
       faah057 LIKE faah_t.faah057, #雜發單號 #160426-00014#15 add
       faah058 LIKE faah_t.faah058  #雜發項次 #160426-00014#15 add
END RECORD
DEFINE g_faaj RECORD  #固定資產帳套折舊資訊資料檔
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
#add by geza 20161121 #161111-00028#6(E)
DEFINE g_flag               LIKE type_t.chr1
DEFINE g_flag_1             LIKE type_t.chr1
DEFINE g_faaj_1             type_g_apcb1_d 
DEFINE g_bookno             LIKE glaa_t.glaald
DEFINE g_apcbdocno          STRING
DEFINE g_para_data          LIKE type_t.chr80
DEFINE g_para_data2         LIKE type_t.chr80
DEFINE g_para_data3         LIKE type_t.chr80
DEFINE g_faal005            LIKE faal_t.faal005
#albireo 160111-----s
#自動編碼元件用的變數
DEFINE g_oofg001_t1         STRING
DEFINE g_before_code        STRING
DEFINE g_num_code           STRING
DEFINE g_after_code         STRING
#albireo 160111-----e
DEFINE g_glaacomp           LIKE glaa_t.glaacomp #161125-00017#1 add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afap200.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success    LIKE type_t.num5   #add--2015/03/20 By shiun
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("afa","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CALL s_aooi390_cre_tmp_table() RETURNING l_success   #add--2015/03/20 By shiun
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL afap200_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afap200 WITH FORM cl_ap_formpath("afa",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL afap200_init()
 
      #進入選單 Menu (="N")
      CALL afap200_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_afap200
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi390_drop_tmp_table()   #add--2015/03/20 By shiun
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="afap200.init" >}
#+ 初始化作業
PRIVATE FUNCTION afap200_init()
 
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
   CALL cl_set_comp_visible("other_check_no_all,other_check_all",FALSE)
#mark by yangxf
#   LET g_master.ooef001 = g_site
#   CALL afap200_get_ooef001_desc()
#   DISPLAY g_master.ooef001 TO ooef001
#   DISPLAY g_master.ooef001_desc TO ooef001_desc
#mark by yangxf
   LET g_master.a = 'N'
   DISPLAY g_master.a TO a
   CALL cl_set_comp_visible("b,b_c,b_faah001",FALSE)  
   CALL cl_set_combo_scc('b_faah002','9911')
   CALL cl_set_combo_scc('f','8060') #160426-00014#1 add
   #160426-00014#15 add s---
   LET g_master.f = '1'  
   CALL cl_set_comp_visible('apca004',TRUE)
   CALL cl_set_comp_visible('imaal004,inbb010,oocal003,xccc280,xccc280_inbb011',FALSE) 
   #160426-00014#15 add e---
 
#   CALL cl_get_para(g_enterprise,g_site,'S-FIN-9005') RETURNING g_para_data   #卡片編號是否自動編號
#   CALL cl_get_para(g_enterprise,g_site,'S-FIN-9002') RETURNING g_para_data2  #财产编号预设是否与卡片编号一致
#   CALL cl_get_para(g_enterprise,g_site,'S-FIN-9010') RETURNING g_para_data3
#   IF g_para_data ='Y' THEN 
#      CALL cl_set_comp_visible("b_faah001",FALSE)
#   ELSE
#      CALL cl_set_comp_visible("b_faah001",TRUE)
#   END IF 
   #CALL cl_set_act_visible("other_check_all,other_check_no_all",FALSE)    
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afap200.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afap200_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_cnt    LIKE type_t.num5
   DEFINE l_flag   LIKE type_t.chr1
   DEFINE l_check  LIKE type_t.chr1
   DEFINE g_apcbdocno_t LIKE apcb_t.apcbdocno
   DEFINE l_apcb002 LIKE apcb_t.apcb002
   DEFINE l_apcb003 LIKE apcb_t.apcb003
   
   CALL afap200_ui_dialog_1()
   RETURN
     
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.fabgsite,g_master.ooef001,g_master.glaald,g_master.f,g_master.a 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
 
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgsite
            
            #add-point:AFTER FIELD fabgsite name="input.a.fabgsite"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.fabgsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.fabgsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.fabgsite_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgsite
            #add-point:BEFORE FIELD fabgsite name="input.b.fabgsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgsite
            #add-point:ON CHANGE fabgsite name="input.g.fabgsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooef001
            
            #add-point:AFTER FIELD ooef001 name="input.a.ooef001"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooef001
            #add-point:BEFORE FIELD ooef001 name="input.b.ooef001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooef001
            #add-point:ON CHANGE ooef001 name="input.g.ooef001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaald
            
            #add-point:AFTER FIELD glaald name="input.a.glaald"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.glaald
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.glaald_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.glaald_desc
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
         BEFORE FIELD f
            #add-point:BEFORE FIELD f name="input.b.f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD f
            
            #add-point:AFTER FIELD f name="input.a.f"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE f
            #add-point:ON CHANGE f name="input.g.f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD a
            #add-point:BEFORE FIELD a name="input.b.a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD a
            
            #add-point:AFTER FIELD a name="input.a.a"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE a
            #add-point:ON CHANGE a name="input.g.a"
 
            #END add-point 
 
 
 
                     #Ctrlp:input.c.fabgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgsite
            #add-point:ON ACTION controlp INFIELD fabgsite name="input.c.fabgsite"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.fabgsite             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
           #CALL q_faab001()                                #呼叫開窗 #161024-00008#1 
            CALL q_ooef001_47()                                      #161024-00008#1 

            LET g_master.fabgsite = g_qryparam.return1              

            DISPLAY g_master.fabgsite TO fabgsite              #

            NEXT FIELD fabgsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.ooef001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooef001
            #add-point:ON ACTION controlp INFIELD ooef001 name="input.c.ooef001"
            #此段落由子樣板a07產生            

            #END add-point
 
 
         #Ctrlp:input.c.glaald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaald
            #add-point:ON ACTION controlp INFIELD glaald name="input.c.glaald"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.glaald             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.arg2 = "" #s
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_master.glaald = g_qryparam.return1              

            DISPLAY g_master.glaald TO glaald              #

            NEXT FIELD glaald                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD f
            #add-point:ON ACTION controlp INFIELD f name="input.c.f"
            
            #END add-point
 
 
         #Ctrlp:input.c.a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a
            #add-point:ON ACTION controlp INFIELD a name="input.c.a"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON apca004,apcadocno,apcadocdt
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.apca004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca004
            #add-point:ON ACTION controlp INFIELD apca004 name="construct.c.apca004"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161028-00023#1--add--str--lujh
            LET g_qryparam.arg1 = "('1','3')"
            CALL q_pmaa001_1() 
            #161028-00023#1--add--end--lujh
            #CALL q_pmaa001_25()        #160913-00017#1  ADD    #161028-00023#1 mark lujh
           # CALL q_pmaa001()      #160913-00017#1 mark          #呼叫開窗
            DISPLAY g_qryparam.return1 TO apca004  #顯示到畫面上
            NEXT FIELD apca004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca004
            #add-point:BEFORE FIELD apca004 name="construct.b.apca004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca004
            
            #add-point:AFTER FIELD apca004 name="construct.a.apca004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcadocno
            #add-point:ON ACTION controlp INFIELD apcadocno name="construct.c.apcadocno"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF g_master.f = '1' THEN #160426-00014#15
               CALL q_apcadocno()                           #呼叫開窗
            #160426-00014#15 add s---   
            ELSE
               LET g_qryparam.where = " inba001 = '1'"
               CALL q_inbadocno_6()
            END IF            
            #160426-00014#15 add e---
            DISPLAY g_qryparam.return1 TO apcadocno  #顯示到畫面上
            NEXT FIELD apcadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcadocno
            #add-point:BEFORE FIELD apcadocno name="construct.b.apcadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcadocno
            
            #add-point:AFTER FIELD apcadocno name="construct.a.apcadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcadocdt
            #add-point:BEFORE FIELD apcadocdt name="construct.b.apcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcadocdt
            
            #add-point:AFTER FIELD apcadocdt name="construct.a.apcadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcadocdt
            #add-point:ON ACTION controlp INFIELD apcadocdt name="construct.c.apcadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD a
            #add-point:BEFORE FIELD a name="construct.b.a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD a
            
            #add-point:AFTER FIELD a name="construct.a.a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a
            #add-point:ON ACTION controlp INFIELD a name="construct.c.a"
            
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
            CALL afap200_get_buffer(l_dialog)
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
         CALL afap200_init()
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
                 CALL afap200_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = afap200_transfer_argv(ls_js)
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
 
{<section id="afap200.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION afap200_transfer_argv(ls_js)
 
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
 
{<section id="afap200.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION afap200_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_cnt    LIKE type_t.num5
   DEFINE l_flag   LIKE type_t.chr1
   DEFINE l_check  LIKE type_t.chr1
   DEFINE g_apcbdocno_t LIKE apcb_t.apcbdocno
   DEFINE l_apcb002 LIKE apcb_t.apcb002
   DEFINE l_apcb003 LIKE apcb_t.apcb003
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE li_idx   LIKE type_t.num5
   
   CALL afap200_process_1(ls_js)
   RETURN 
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
#  DECLARE afap200_process_cs CURSOR FROM ls_sql
#  FOREACH afap200_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
#            IF cl_ask_promp('afa-00035') THEN
#               LET g_flag = 'N'                 #未稅
#            ELSE
#               LET g_flag = 'Y'                 #含稅
#            END IF
#            
#            #若主帳套都未勾選，需提示
#            LET l_check = 'N'
#            FOR li_idx = 1 TO g_apcb_d.getLength()
#                IF g_apcb_d[li_idx].b = 'Y' THEN 
#                   LET l_check = 'Y'
#                END IF                
#            END FOR
#            IF l_check = 'N' THEN   #表示都未勾選
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'afa-00041'
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#
#            END IF
 

            
            #錯誤訊息彙總初始
           #CALL cl_showmsg_init()       #150731-00004#1 20150807 mark
            CALL cl_err_collect_init()   #150731-00004#1 20150807 add
             
            LET l_flag = 'Y'   #標記是否已產生資料
            LET g_flag_1 = 'Y' #標記是否可以產生成功 
            LET g_apcbdocno_t = ' '
            
            #chenying add--str--#20141123

            
            #若主帳套都未勾選，需提示
            LET l_check = 'N'
            FOR li_idx = 1 TO g_apcb_d.getLength()
                IF g_apcb_d[li_idx].b = 'Y' THEN 
                   LET l_check = 'Y'
                END IF                
            END FOR
            IF l_check = 'N' THEN   #表示都未勾選
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00041'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_flag_1 = 'N'               
            ELSE
               IF cl_ask_promp('afa-00035') THEN
                  LET g_flag = 'N'                 #未稅
               ELSE
                  LET g_flag = 'Y'                 #含稅
               END IF
            END IF            
            #chenying add--end--
            FOR li_idx = 1 TO g_apcb_d.getLength()
                IF g_apcb_d[li_idx].b = 'Y' THEN 
                   IF g_master.a = 'Y' THEN    #在建工程產生faak_t底稿；非在建工程產生faah_t底稿
                      #chenying add--str--
                      #20141123            

#                      IF cl_null(g_apcb_d[li_idx].apcb016) OR cl_null(g_apcb_d[li_idx].apcb015) THEN
#                         INITIALIZE g_errparam TO NULL
#                         LET g_errparam.code = 'afa-00295'
#                         LET g_errparam.extend = ''
#                         LET g_errparam.popup = TRUE
#                         CALL cl_err()  
#                         LET l_flag = 'N'  
#                         LET g_flag_1 = 'N' 
#                      END IF                               
             
                      #chenying add--end--
                      
                      #已產生底稿的應付帳款不能再次拋轉
                      IF g_apcb_d[li_idx].apcbdocno <> g_apcbdocno_t THEN 
                         IF g_master.f ='1' THEN #160426-00014#15 add
                            SELECT COUNT(*) INTO l_cnt FROM faak_t
                             WHERE faakent = g_enterprise
                              AND faakld = g_master.glaald
                              AND faak041 = g_apcb_d[li_idx].apcbdocno 
                              AND faak044 = g_apcb_d[li_idx].apcbseq
                         #160426-00014#15 add s---     
                         ELSE
                            SELECT COUNT(*) INTO l_cnt FROM faak_t
                             WHERE faakent = g_enterprise
                              AND faakld = g_master.glaald
                              AND faak047 = g_apcb_d[li_idx].apcbdocno 
                              AND faak045 = g_apcb_d[li_idx].apcbseq                         
                         END IF                   
                         #160426-00014#15 add e---                         
                         IF l_cnt > 0 THEN
                            #150731-00004#1 20150807 str---
                           #CALL cl_errmsg('',g_apcb_d[li_idx].apcbdocno,'','afa-00038',1)
                            INITIALIZE g_errparam TO NULL
                            LET g_errparam.code = 'afa-00038'
                            LET g_errparam.extend = g_apcb_d[li_idx].apcbdocno
                            LET g_errparam.popup = TRUE
                            CALL cl_err()
                            #150731-00004#1 20150807 end---
                            LET l_flag = 'N'  
                            LET g_flag_1 = 'N'                        
                         END IF 
                      END IF
                      LET g_apcbdocno_t = g_apcb_d[li_idx].apcbdocno
                     
                      CALL s_transaction_begin()                     
                      IF l_flag = 'Y' THEN   
                         LET g_success = TRUE  
                         #chenying mod--str-- 
                         #20141123 项目编号+WBS为必输项，当apcb抓不到值自行输入后ins到faak中
                         #需传入项目编号+WBS的值
#                         CALL afap200_ins_faak(g_apcb_d[li_idx].apcald,g_apcb_d[li_idx].apcbdocno,g_apcb_d[li_idx].apcbseq,g_apcb_d[li_idx].apca004,g_apcb_d[li_idx].t,g_apcb_d[li_idx].apca100)
#                         CALL afap200_ins_faak(g_master.glaald,g_apcb_d[li_idx].apcbdocno,g_apcb_d[li_idx].apcbseq,
#                                               g_apcb_d[li_idx].apca004,g_apcb_d[li_idx].t,g_apcb_d[li_idx].apca100,
#                                               g_apcb_d[li_idx].apcb015,g_apcb_d[li_idx].apcb016)
                         #chenying mod--end--                      
#                         RETURNING g_success   
                         IF g_success = FALSE THEN  #多筆數據中有返回FALSE就先標記
                            LET g_flag_1 = 'N'
                         ELSE
                            IF cl_null(g_apcbdocno) THEN 
                               #LET g_apcbdocno="'",g_apcb_d[li_idx].apcbdocno,"' AND faak044=",g_apcb_d[li_idx].apcbseq,")" #160426-00014#15 mark
                               LET g_apcbdocno="'",g_apcb_d[li_idx].apcbdocno,"' AND (faak044=",g_apcb_d[li_idx].apcbseq," OR faak045=",g_apcb_d[li_idx].apcbseq," ))"  #160426-00014#15 add
                            ELSE
                               #LET g_apcbdocno=g_apcbdocno," OR ( faak041='",g_apcb_d[li_idx].apcbdocno,"' AND faak044 =",g_apcb_d[li_idx].apcbseq,")" #160426-00014#15 mark
                               LET g_apcbdocno=g_apcbdocno," OR ( faak041='",g_apcb_d[li_idx].apcbdocno,"' AND faak044 =",g_apcb_d[li_idx].apcbseq,") OR ( faak047='",g_apcb_d[li_idx].apcbdocno,"' AND faak045 =",g_apcb_d[li_idx].apcbseq,")"  #160426-00014#15 add 
                            END IF
                         END IF
                      END IF   
                   ELSE
                      #已產生卡片的應付帳款不能再次拋轉
                      IF g_apcb_d[li_idx].apcbdocno <> g_apcbdocno_t THEN
                         IF g_master.f ='1' THEN #160426-00014#15 add                      
                            SELECT COUNT(*) INTO l_cnt FROM faah_t
                             WHERE faahent = g_enterprise
                              #AND faahld = g_apcb_d[li_idx].apcald
                              AND faah040 = g_apcb_d[li_idx].apcbdocno 
                              AND faah045 = g_apcb_d[li_idx].apcbseq
                         #160426-00014#15 add s---     
                         ELSE
                            SELECT COUNT(*) INTO l_cnt FROM faah_t
                             WHERE faahent = g_enterprise
                              #AND faahld = g_apcb_d[li_idx].apcald
                              AND faah057 = g_apcb_d[li_idx].apcbdocno 
                              AND faah058 = g_apcb_d[li_idx].apcbseq                         
                         END IF                   
                         #160426-00014#15 add e---                         
                        IF l_cnt > 0 THEN
                           #150731-00004#1 20150807 str---
                           #CALL cl_errmsg('',g_apcb_d[li_idx].apcbdocno,'','afa-00038',1)
                            INITIALIZE g_errparam TO NULL
                            LET g_errparam.code = 'afa-00038'
                            LET g_errparam.extend = g_apcb_d[li_idx].apcbdocno
                            LET g_errparam.popup = TRUE
                            CALL cl_err()
                            #150731-00004#1 20150807 end---
                           LET l_flag = 'N'  
                           LET g_flag_1 = 'N'                        
                        END IF 
                     END IF
                     LET g_apcbdocno_t = g_apcb_d[li_idx].apcbdocno
                     
                     IF l_flag = 'Y' THEN
                        LET g_success = TRUE  
                        #通過應付帳款單據+項次獲取對應來源業務單+項次
                        SELECT apcb002,apcb003 INTO l_apcb002,l_apcb003
                          FROM apcb_t
                         WHERE apcbdocno = g_apcb_d[li_idx].apcbdocno
                           AND apcbseq = g_apcb_d[li_idx].apcbseq
                           AND apcbent= g_enterprise                           
#                        CALL afap200_ins_faah(g_master.glaald,g_apcb_d[li_idx].apcbdocno,g_apcb_d[li_idx].apcbseq,
#                                              g_apcb_d[li_idx].apca004,g_apcb_d[li_idx].t,g_apcb_d[li_idx].apca100,
#                                              g_apcb_d[li_idx].b,g_apcb_d[li_idx].c,l_apcb002,l_apcb003,g_apcb_d[li_idx].apcb015,g_apcb_d[li_idx].apcb016)
#                          RETURNING g_success
                        IF g_success = FALSE THEN  #多筆數據中有返回FALSE就先標記
                           LET g_flag_1 = 'N'
                        ELSE 
                           IF cl_null(g_apcbdocno) THEN 
                              #LET g_apcbdocno="'",g_apcb_d[li_idx].apcbdocno,"' AND faah045=",g_apcb_d[li_idx].apcbseq,")" #160426-00014#15 mark
                              LET g_apcbdocno="'",g_apcb_d[li_idx].apcbdocno,"' AND (faah045=",g_apcb_d[li_idx].apcbseq," OR faah058=",g_apcb_d[li_idx].apcbseq," ))"  #160426-00014#15 add
                           ELSE
                              #LET g_apcbdocno=g_apcbdocno," OR (faah040='",g_apcb_d[li_idx].apcbdocno,"' AND faah045=",g_apcb_d[li_idx].apcbseq,")" #160426-00014#15 mark
                              LET g_apcbdocno=g_apcbdocno," OR (faah040='",g_apcb_d[li_idx].apcbdocno,"' AND faah045=",g_apcb_d[li_idx].apcbseq,") OR (faah057='",g_apcb_d[li_idx].apcbdocno,"' AND faah058=",g_apcb_d[li_idx].apcbseq,") "  #160426-00014#15 add
                           END IF
                        END IF  
                     END IF   
                   END IF 
              END IF                
            END FOR 
            #CALL cl_err_showmsg()       #150731-00004#1 20150807 mark
            CALL cl_err_collect_show()   #150731-00004#1 20150807 add
            IF g_flag_1 = 'N' THEN    #有返回False的標記就提示失敗，插入失敗
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'adz-00218'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err() 
               LET g_success = FALSE
            ELSE
               CALL s_transaction_end('Y','0')  
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'adz-00217'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()    
               IF g_master.a = 'Y' THEN
                  LET la_param.prog = 'afai120'
                  IF g_master.f = '1' THEN #160426-00014#15 add
                     LET la_param.param[7] = g_apcbdocno
                  #160426-00014#15 add s---   
                  ELSE
                     LET la_param.param[8] = g_apcbdocno
                  END IF
                  #160426-00014#15 add e---                     
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun(ls_js)
               ELSE
                  LET la_param.prog = 'afai100'
                  IF g_master.f = '1' THEN #160426-00014#15 add
                     LET la_param.param[5] = g_apcbdocno
                  #160426-00014#15 add s---   
                  ELSE
                     LET la_param.param[7] = g_apcbdocno
                  END IF
                  #160426-00014#15 add e---
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun(ls_js)
               END IF
            END IF      
            LET INT_FLAG = TRUE
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL afap200_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="afap200.get_buffer" >}
PRIVATE FUNCTION afap200_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.fabgsite = p_dialog.getFieldBuffer('fabgsite')
   LET g_master.ooef001 = p_dialog.getFieldBuffer('ooef001')
   LET g_master.glaald = p_dialog.getFieldBuffer('glaald')
   LET g_master.f = p_dialog.getFieldBuffer('f')
   LET g_master.a = p_dialog.getFieldBuffer('a')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afap200.msgcentre_notify" >}
PRIVATE FUNCTION afap200_msgcentre_notify()
 
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
 
{<section id="afap200.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
################################################################################
# Descriptions...: 獲取法人組織說明
# Memo...........:
# Usage..........: afap200_get_ooef001_desc()
#                   
# Input parameter:  
#                :  
# Return code....:  
#                :  
# Date & Author..: 2014/2/24 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_get_ooef001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.ooef001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.ooef001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.ooef001_desc
END FUNCTION
################################################################################
# Descriptions...: 查詢
# Memo...........:
# Usage..........: CALL afap200_construct()
#                   
# Input parameter:  
#                :  
# Return code....:  
#                :  
# Date & Author..: 2014/2/24 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_construct()
DEFINE l_success LIKE type_t.chr1
DEFINE l_origin_str           STRING 
DEFINE l_str                  STRING  #160923-00015#4--add
DEFINE l_faah003 LIKE gzzd_t.gzzd005  #160923-00015#4--add

   CLEAR FORM
   INITIALIZE g_master.* TO NULL
   CALL g_apcb_d.clear()
     
   LET g_master.a = 'N'
   
   INITIALIZE g_wc2 TO NULL
   LET g_master.fabgsite = g_site 
   CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,g_master.ooef001,g_master.glaald
   CALL s_fin_account_center_with_ld_chk(g_site,g_master.glaald,g_user,'5','N','',g_today) RETURNING g_sub_success,g_errno
   IF NOT g_sub_success THEN 
      LET g_master.ooef001 = ''
      LET g_master.glaald = ''
   END IF 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT BY NAME g_master.fabgsite,g_master.ooef001
       ATTRIBUTE(WITHOUT DEFAULTS)
      
         BEFORE INPUT 
            CALL afap200_get_ooef001_desc()
            CALL afap200_get_fabgsite_desc()
            CALL afap200_get_glaald_desc()            
            DISPLAY BY NAME g_master.fabgsite,g_master.ooef001,g_master.glaald
      
         AFTER FIELD fabgsite
            IF NOT cl_null(g_master.fabgsite) THEN 
                #检查组织资料的合理性
               IF NOT s_afat502_site_chk(g_master.fabgsite) THEN
                  LET g_master.fabgsite = ''
                  CALL afap200_get_fabgsite_desc()
                  DISPLAY BY NAME g_master.fabgsite
                  NEXT FIELD CURRENT
               END IF
               #帐套不为空检查法人归属是否相同
               IF NOT cl_null(g_master.glaald) THEN
                  IF NOT s_afat502_site_ld_chk(g_master.fabgsite,g_master.glaald) THEN
                     LET g_master.fabgsite = ''
                     CALL afap200_get_fabgsite_desc()
                     DISPLAY BY NAME g_master.fabgsite
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL afap200_get_fabgsite_desc()
               DISPLAY BY NAME g_master.fabgsite
            ELSE
               CALL afap200_get_fabgsite_desc()
               DISPLAY BY NAME g_master.fabgsite
            END IF 
            
         
         AFTER FIELD ooef001
            IF NOT cl_null(g_master.ooef001) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.ooef001
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_7") THEN
               ELSE
                  LET g_master.ooef001 = '' 
                  LET g_master.ooef001_desc = ''
                  DISPLAY BY NAME g_master.ooef001,g_master.ooef001_desc
                  NEXT FIELD CURRENT
               END IF 
               IF NOT cl_null(g_master.fabgsite) THEN 
                  IF NOT afap200_site_comp_chk(g_master.fabgsite,g_master.ooef001) THEN 
                     LET g_master.ooef001_desc = ''
                     DISPLAY BY NAME g_master.ooef001,g_master.ooef001_desc
                     NEXT FIELD CURRENT
                  END IF 
               END IF 
               #获取主帐套
               CALL afap200_glaald_get()
               CALL afap200_get_glaald_desc()  
               IF NOT cl_null(g_master.glaald) THEN
                  IF NOT cl_null(g_master.fabgsite) THEN                
                     IF NOT s_afat502_site_ld_chk(g_master.fabgsite,g_master.glaald) THEN
                        LET g_master.ooef001 = '' 
                        LET g_master.ooef001_desc = ''
                        LET g_master.glaald = ''
                        LET g_master.glaald_desc = ''
                        DISPLAY BY NAME g_master.ooef001,g_master.ooef001_desc,g_master.glaald,g_master.glaald_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "afa-00305"
                  LET g_errparam.code   = STATUS
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_master.ooef001 = '' 
                  LET g_master.ooef001_desc = ''
                  DISPLAY BY NAME g_master.ooef001,g_master.ooef001_desc,g_master.glaald,g_master.glaald_desc
                  NEXT FIELD CURRENT
               END IF 
            ELSE
               LET g_master.glaald = ''
               LET g_master.glaald_desc = ''
               DISPLAY BY NAME g_master.glaald,g_master.glaald_desc
            END IF
            CALL afap200_get_ooef001_desc()

          ON ACTION controlp INFIELD ooef001
	  	       INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'i'
	  	       LET g_qryparam.reqry = FALSE
             LET g_qryparam.default1 = g_master.ooef001      #給予default值
             IF NOT cl_null(g_master.fabgsite) THEN 
                CALL s_fin_create_account_center_tmp()
                CALL s_fin_account_center_sons_query('5',g_master.fabgsite,g_today,'1')
                CALL s_fin_account_center_comp_str()RETURNING l_origin_str
                CALL afap200_change_to_sql(l_origin_str)RETURNING l_origin_str
                #LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN(",l_origin_str CLIPPED,") " #161024-00008#1 
                LET g_qryparam.where = "  ooef001 IN(",l_origin_str CLIPPED,") "                   #161024-00008#1 
             END IF                                                                                
             #CALL q_ooef001()                              #呼叫開窗                               #161024-00008#1 
             CALL q_ooef001_2()                                                                    #161024-00008#1 
             LET g_master.ooef001 = g_qryparam.return1       #將開窗取得的值回傳到變數
             DISPLAY g_master.ooef001 TO ooef001             #顯示到畫面上
             CALL afap200_get_ooef001_desc()
             NEXT FIELD ooef001                              #返回原欄位  
            
          ON ACTION controlp INFIELD fabgsite
	  	       INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'i'
	  	       LET g_qryparam.reqry = FALSE
             LET g_qryparam.default1 = g_master.fabgsite      #給予default值
             LET g_qryparam.where = " ooef207 = 'Y' "
             CALL q_ooef001() 
             LET g_master.fabgsite = g_qryparam.return1       #將開窗取得的值回傳到變數
             DISPLAY g_master.fabgsite TO fabgsite             #顯示到畫面上
             CALL afap200_get_fabgsite_desc()
             NEXT FIELD fabgsite                              #返回原欄位  
        AFTER INPUT
     END INPUT
     
     CONSTRUCT BY NAME g_wc2 ON apca004,apcadocno,apcadocdt
       BEFORE CONSTRUCT
          CALL cl_qbe_init() 

       ON ACTION controlp INFIELD apcadocno     #單據單號開窗
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
		    LET g_qryparam.reqry = FALSE
            IF g_master.f = '1' THEN #160426-00014#15
		         LET g_qryparam.where = " apcacomp = '",g_master.ooef001,"' AND apcadocno NOT IN (SELECT faah040 FROM faah_t WHERE faah040<>' ') ",
		                                " AND apcastus = 'Y' "   #160930-00018#1 add lujh
               CALL q_apcadocno()                    #呼叫開窗            
            #160426-00014#15 add s---   
            ELSE
               LET g_qryparam.where = " inba001 = '1' AND inbadocno NOT IN(SELECT faah057 FROM faah_t WHERE faah057<>' ') AND inbastus = 'S' "
               CALL q_inbadocno_6()
            END IF            
            #160426-00014#15 add e---		    

          DISPLAY g_qryparam.return1 TO apcadocno  #顯示到畫面上
          NEXT FIELD apcadocno
          
       ON ACTION controlp INFIELD apca004  #帳款客戶開窗
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
		    LET g_qryparam.reqry = FALSE
		    #161028-00023#1--add--str--lujh
          LET g_qryparam.arg1 = "('1','3')"
          CALL q_pmaa001_1() 
          #161028-00023#1--add--end--lujh
		    #CALL q_pmaa001_25()        #160913-00017#1  ADD     #161028-00023#1 mark lujh
         # CALL q_pmaa001()          #160913-00017#1  MARK
          DISPLAY g_qryparam.return1 TO apca004    #顯示到畫面上
          NEXT FIELD apca004 
          
         
      END CONSTRUCT   
      #INPUT BY NAME g_master.a           #160426-00014#15 mark
      INPUT BY NAME g_master.a,g_master.f #160426-00014#15 add      
         #160426-00014#15 add s---
         ON CHANGE f
            IF g_master.f = '1' THEN 
               CALL cl_set_comp_visible('apca004',TRUE)
               CALL cl_set_comp_visible('imaal004,inbb010,oocal003,xccc280,xccc280_inbb011',FALSE) 
               LET l_str = cl_getmsg("afa-01146",g_lang)  
               CALL cl_set_comp_att_text('b_apca004',l_str) 
               LET l_str = cl_getmsg("afa-01147",g_lang)  
               CALL cl_set_comp_att_text('apca004_desc',l_str) 
               LET l_str = cl_getmsg("afa-01148",g_lang)  
               CALL cl_set_comp_att_text('apcb005',l_str)                
            ELSE
               CALL cl_set_comp_visible('apca004',FALSE) 
               CALL cl_set_comp_visible('apca100,apcb103,apcb105,apcb113,apcb115,apcb015,apcb016,apcb047',FALSE)
               CALL cl_set_comp_visible('imaal004,inbb010,oocal003,xccc280,xccc280_inbb011',TRUE)   
               LET l_str = cl_getmsg("afa-01145",g_lang)  
               CALL cl_set_comp_att_text('b_apca004',l_str)  
               LET l_str = cl_getmsg("sub-01386",g_lang)  
               CALL cl_set_comp_att_text('apca004_desc',l_str)  
               LET l_str = cl_getmsg("adb-00384",g_lang)  
               CALL cl_set_comp_att_text('apcb005',l_str)               
            END IF
         #160426-00014#15 add e---      
      END INPUT
      BEFORE DIALOG
         LET g_master.a = 'N'
         DISPLAY g_master.a TO a
          
         #160426-00014#15 add s---
         LET g_master.f = '1'
         DISPLAY g_master.f TO f  
         CALL afap200_show()         
         #160426-00014#15 add e---         
 

 
      ON ACTION qbe_select      
 
      ON ACTION qbe_save       
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
      &include "main_menu.4gl"
      &include "relating_action.4gl"
         CONTINUE DIALOG
   END DIALOG
   IF cl_null(g_wc2) THEN 
      LET g_wc2 = " 1=1 "
   END IF 
   IF INT_FLAG THEN
      RETURN
   END IF     
   CALL cl_get_para(g_enterprise,g_master.ooef001,'S-FIN-9005') RETURNING g_para_data   #卡片編號是否自動編號
   CALL cl_get_para(g_enterprise,g_master.ooef001,'S-FIN-9002') RETURNING g_para_data2  #财产编号预设是否与卡片编号一致
   CALL cl_get_para(g_enterprise,g_master.ooef001,'S-FIN-9010') RETURNING g_para_data3
   IF g_para_data ='Y' THEN 
      CALL cl_set_comp_visible("b_faah001",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_faah001",TRUE)
   END IF
   #160923-00015#4--add--s--
   IF g_master.a ='Y' THEN
      LET l_str = cl_getmsg("afa-01136",g_lang)
      CALL cl_set_comp_att_text('b_faah003',l_str)
   ELSE
      SELECT gzzd005 INTO l_faah003 FROM gzzd_t
    WHERE gzzdstus = 'Y'
      AND gzzd001  = 'afap200'
      AND gzzd002  = g_lang
      AND gzzd003  = 'lbl_faah003'
      
      CALL cl_set_comp_att_text('b_faah003',l_faah003)      
   END IF
   #160923-00015#4--add--e--
END FUNCTION
################################################################################
# Descriptions...: 獲取主帳套說明
# Memo...........:
# Usage..........: CALL afap200_get_apcald_desc()
#                    
# Input parameter:  
#                :  
# Return code....:  
#                :  
# Date & Author..: 2014/2/24 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_get_apcald_desc()
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_apcb_d[l_ac].apcald
#   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_lang||"'","") RETURNING g_rtn_fields
#   LET g_apcb_d[l_ac].apcald_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_apcb_d[l_ac].apcald_desc
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL afap200_get_apca004_desc()
#                  
# Input parameter:  
#                :  
# Return code....:  
#                :  
# Date & Author..: 2014/2/24 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_get_apca004_desc()
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_apcb_d[l_ac].apca004
#   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_lang||"'","") RETURNING g_rtn_fields
#   LET g_apcb_d[l_ac].apca004_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_apcb_d[l_ac].apca004_desc 
END FUNCTION
################################################################################
# Descriptions...: 獲取單身資料
# Memo...........:
# Usage..........: CALL afap200_apcb_fill(p_wc)
#                   
# Input parameter:  
#                :  
# Return code....:  
#                :  
# Date & Author..: 2014/2/25 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_apcb_fill(p_wc)
   DEFINE p_wc              STRING
   DEFINE l_sql             STRING
   DEFINE l_max             LIKE type_t.chr10
   DEFINE l_ym              LIKE type_t.chr10
   DEFINE l_yy              LIKE type_t.num5
   DEFINE l_mm              LIKE type_t.num5
   DEFINE l_cy              LIKE type_t.chr4
   DEFINE l_cm              LIKE type_t.chr2
   DEFINE l_t               LIKE type_t.chr80
   DEFINE l_glaa120         LIKE glaa_t.glaa120 #160426-00014#15 add
   DEFINE l_year            LIKE type_t.num5    #160426-00014#15 add
   DEFINE l_month           LIKE type_t.num5    #160426-00014#15 add
   #160426-00014#15 add s---
   DEFINE l_inbc001         LIKE inbc_t.inbc001 
   DEFINE l_inbc002         LIKE inbc_t.inbc002 
   DEFINE l_inbc005         LIKE inbc_t.inbc005 
   DEFINE l_inbc007         LIKE inbc_t.inbc007 
   DEFINE l_inbc003         LIKE inbc_t.inbc003 
   #160426-00014#15 add e---
   
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 "
   END IF
   DELETE FROM afap200_tmp02      # 160727-00019#1 Mod  afap200_apcb_tmp--> afap200_tmp02
    
   CALL cl_err_collect_init() #160426-00014#15 add
   
   IF g_master.f = '1' THEN #160426-00014#15 add 
      #LET l_sql= " SELECT '',apcbld,'',apcbdocno,apcbseq,apcadocdt,apca004,'',apca100,apcb004,apcb005,apcb007,apcb103,apcb105,apcb113,apcb115,apcb015,apcb016,apcb047,'','','','',' ','','','','', ", #161019-00042#1 add apcb047 #160426-00014#15 mark
      LET l_sql= " SELECT '',apcbld,'',apcbdocno,apcbseq,apcadocdt,apca004,(SELECT pmaal004 FROM pmaal_t WHERE pmaalent=",g_enterprise," AND pmaal001=apca004 AND pmaal002='",g_lang,"'),", #160426-00014#15 add 
                 "    apca100,apcb004,apcb005,'','','',apcb007,'','',apcb103,apcb105,apcb113,apcb115,apcb015,apcb016,apcb047,'','','','',' ','','','','', ",    #160426-00014#15 add        
                 "    '','','','' ",   #albireo 160111   
                 "   FROM apcb_t LEFT OUTER JOIN apca_t ON apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
                 "               LEFT OUTER JOIN glaa_t ON glaaent = apcbent AND glaald = apcbld ",
                 "  WHERE apcbent = '",g_enterprise,"'",
                 "    AND apcacomp = '",g_master.ooef001,"'",
#                 "    AND apcbsite = '",g_master.fabgsite,"'",
                 "    AND apcbld = '",g_master.glaald,"'",
                 "    AND NOT EXISTS (SELECT 1 FROM faah_t WHERE faah040=apcbdocno AND faahent=",g_enterprise," AND faah045=apcbseq AND faah040 <>' ')", #160905-00007#1 add
                 "    AND NOT EXISTS (SELECT 1 FROM faak_t WHERE faak041=apcbdocno AND faakent=",g_enterprise," AND faak044=apcbseq AND faak041 <>' ')", #160905-00007#1 add
#                 "    AND (apcadocno NOT IN (SELECT faah040 FROM faah_t,apcb_t WHERE faah040=apcbdocno AND faah045=apcbseq AND faah040 <>' ') ",
#                 "     OR apcbseq NOT IN (SELECT faah045 FROM faah_t,apcb_t WHERE faah040=apcbdocno AND faah045=apcbseq AND faah040 <>' ') )",
#                 "    AND (apcadocno NOT IN (SELECT faak041 FROM faak_t,apcb_t WHERE faak041=apcbdocno AND faak044=apcbseq AND faak041 <>' ')" ,
#                 "     OR apcbseq NOT IN (SELECT faak044 FROM faak_t,apcb_t WHERE faak041=apcbdocno AND faak044=apcbseq AND faak041 <>' ') )" ,             
                 "    AND glaa014 = 'Y' ",
                 "    AND (apca016 <> '15' OR apca016 IS NULL) ",
                 "    AND ",p_wc,
                 "    AND apcastus = 'Y' ",
                 "    AND (apcb001 IN('11','12','13','14','16','17','18','19') OR apcb001 IS NULL)",
                 "    AND (apca001 IN('01','03','11','13','14','15','16','17','19','31')) ",
                 "    AND apcb023 = 'N' ",
                 "  ORDER BY apcbdocno,apcbseq,apcadocdt,apca004 "
   #160426-00014#15 add s---
   ELSE
      LET p_wc = cl_replace_str(p_wc,"apca005","''")
      LET p_wc = cl_replace_str(p_wc,"apca","inba")
      LET p_wc = cl_replace_str(p_wc,"apcb","inbb")
      LET l_sql= " SELECT DISTINCT '',(SELECT glaald FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaa014 = 'Y' AND glaacomp = (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"')),",
                 "        '',inbadocno,inbbseq,inbadocdt,inba003,(SELECT ooag011 FROM ooag_t WHERE ooagent = ",g_enterprise," AND ooag001 = inba003),",
                 "        '',inbb001,(SELECT imaal003 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = inbb001 AND imaal002 = '",g_dlang,"'),",
                 "        (SELECT imaal004 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = inbb001 AND imaal002 = '",g_dlang,"'),",
                 "        inbb010,(SELECT oocal003 FROM oocal_t WHERE oocalent = ",g_enterprise," AND oocal001 = inbb010 AND oocal002 = '",g_dlang,"'),inbb011,'','',",
                 "    '','','','','','','','','','','',' ','','','','', ",   
                 "    '','','','', ",  
                 "    inbc001,inbc002,inbc005,inbc007,inbc003 ",                 
                 "   FROM inba_t LEFT OUTER JOIN inbb_t ON inbaent = inbbent AND inbadocno = inbbdocno ",
                 "   LEFT OUTER JOIN inbc_t ON inbaent = inbcent AND inbadocno = inbcdocno ",
                 "  WHERE inbaent = '",g_enterprise,"'",
                 "    AND inbasite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef017 ='",g_master.ooef001,"')",
                 "    AND inba001 = '1'",#雜發
                 "    AND NOT EXISTS (SELECT 1 FROM faah_t WHERE faah057=inbbdocno AND faahent=",g_enterprise," AND faah058=inbbseq AND faah040 <>' ')",  #chenying 替換對應雜發單號faah057 58 
                 "    AND NOT EXISTS (SELECT 1 FROM faak_t WHERE faak047=inbbdocno AND faakent=",g_enterprise," AND faak045=inbbseq AND faak047 <>' ')",          
                 "    AND ",p_wc,
                 "    AND inbastus = 'S' ",
                 "  ORDER BY inbadocno,inbbseq,inbadocdt,inba003 "      
   END IF
   
   LET l_glaa120 = NULL
   SELECT glaa120 INTO l_glaa120 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.glaald      
   #160426-00014#15 add e---   
      
      
      
   PREPARE apcb_pre FROM l_sql
   DECLARE apcb_cur CURSOR FOR apcb_pre

   CALL g_apcb_d.clear()
   LET g_cnt = 1
   LET l_t = ''
   FOREACH apcb_cur INTO g_apcb_d[g_cnt].*,l_inbc001,l_inbc002,l_inbc005,l_inbc007,l_inbc003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET g_apcb_d[g_cnt].b = "N"
      LET g_apcb_d[g_cnt].c = "N"   #默认[產生其他帳套]不勾選
      

#160426-00014#15 mark s---      
#      #獲取帳款客戶簡稱
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_apcb_d[g_cnt].apca004
#      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_lang||"'","") RETURNING g_rtn_fields
#      LET g_apcb_d[g_cnt].apca004_desc = '', g_rtn_fields[1] , ''
#160426-00014#15 mark e---
     
      #160426-00014#15 add s---
      LET l_year = YEAR(g_apcb_d[g_cnt].apcadocdt)
      LET l_month = MONTH(g_apcb_d[g_cnt].apcadocdt)
      CALL s_cost_price_get_item_cost(g_site,g_master.glaald,'',l_glaa120,l_year,l_month-1,l_inbc001,l_inbc002,l_inbc005,l_inbc007,l_inbc003,'') 
         RETURNING g_success,g_apcb_d[g_cnt].xccc280 

      LET g_apcb_d[g_cnt].xccc280_inbb011 = g_apcb_d[g_cnt].xccc280 * g_apcb_d[g_cnt].apcb007     
      IF cl_null(g_apcb_d[g_cnt].xccc280_inbb011) THEN LET g_apcb_d[g_cnt].xccc280_inbb011 = 0 END IF      
      #160426-00014#15 add e---
      
      #產生批號
      LET l_yy = YEAR(g_today)
      LET l_mm = MONTH(g_today) 
      LET l_cy = l_yy USING '&&&&'
      LET l_cm = l_mm USING '&&'
      LET l_ym = l_cy,l_cm
      IF g_master.a ='Y' THEN  
         SELECT MAX(faak000) INTO l_max FROM faak_t WHERE faakent=g_enterprise   #在建  #160905-00007#1 add
      ELSE
         SELECT MAX(faah000) INTO l_max FROM faah_t WHERE faahent=g_enterprise   #非在建 #160905-00007#1 add
      END IF      
      IF cl_null(l_t) THEN       
         IF NOT cl_null(l_max) THEN 
            #最大批號是否與當前年月匹配
            IF l_max[1,6] MATCHES l_ym THEN   
               LET g_apcb_d[g_cnt].t = l_max + 1 USING '&&&&&&&&&&'  #匹配則在最大批號基礎上加1 
            ELSE
               LET g_apcb_d[g_cnt].t = l_ym,'1' USING '&&&&'         #不匹配則按當前年月組合批號      
            END IF         
         ELSE
            LET g_apcb_d[g_cnt].t = l_ym,'1' USING '&&&&'            
         END IF
         LET l_t =  g_apcb_d[g_cnt].t
      ELSE
         LET g_apcb_d[g_cnt].t = l_t + 1 USING '&&&&&&&&&&' 
         LET l_t = g_apcb_d[g_cnt].t
      END IF       
      INSERT INTO afap200_tmp02 VALUES(g_apcb_d[g_cnt].*)     # 160727-00019#1 Mod  afap200_apcb_tmp--> afap200_tmp02
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "afap200_tmp02"     # 160727-00019#1 Mod  afap200_apcb_tmp--> afap200_tmp02
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00002"
         LET g_errparam.extend = "Max_Row:"||g_max_rec USING "<<<<<"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_apcb_d.deleteElement(g_cnt)
   
   LET g_rec_b = g_cnt - 1
   LET g_cnt = 0
   CALL afap200_show()        #160426-00014#15
   CALL cl_err_collect_show() #160426-00014#15
   FREE apcb_pre
END FUNCTION
################################################################################
# Descriptions...: 獲取其他帳套資料
# Memo...........:
# Usage..........: afap200_apcb_1_fill(p_apcb002,p_apcb003)
#                   
# Input parameter:  
#                :  
# Return code....:  
#                :  
# Date & Author..: 2014/2/28 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_apcb_1_fill(p_apcb002,p_apcb003)
   DEFINE l_sql             STRING
   DEFINE p_apcb002         LIKE apcb_t.apcbdocno
   DEFINE p_apcb003         LIKE apcb_t.apcbseq
   
   

                
#   LET l_sql= " SELECT apcald_1,apcald,apcald_desc,apcbdocno,apcbseq,apcadocdt,apca004,apca004_desc,apca100,apcb004,apcb005,apcb103,apcb105,apcb113,apcb115",                
#              "   FROM afap200_tmp01 ",      # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
#              "  WHERE apcb002 = '",p_apcb002,"' ",
#              "    AND apcb003 = ",p_apcb003, 
#              "  AND (apca001='13' OR apca001='19')",
#              " AND apcb001='11'",
#              "  ORDER BY apcald,apcbdocno "
#   LET l_sql= " SELECT apcald_1,apcald,apcald_desc,apcbdocno,apcbseq,apcadocdt,apca004,apca004_desc,apca100,apcb004,apcb005,apcb103,apcb105,apcb113,apcb115",   #160426-00014#15 mark
      LET l_sql= " SELECT apcald_1,apcald,apcald_desc,apcbdocno,apcbseq,apcadocdt,apca004,apca004_desc,apca100,apcb004,apcb005,imaal004,apcb103,apcb105,apcb113,apcb115", #160426-00014#15 add
              "   FROM afap200_tmp01 ",               # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
              "  WHERE apcbdocno = '",p_apcb002,"' ",
              "    AND apcbseq = ",p_apcb003, 
              "  ORDER BY apcald,apcbdocno,apcbseq,apcadocdt,apca004 "
   PREPARE apcb_pre2 FROM l_sql
   DECLARE apcb_cur2 CURSOR FOR apcb_pre2

    
   LET g_cnt = 1
   FOREACH apcb_cur2 INTO g_apcb1_d[g_cnt].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach2:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
 
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00002"
         LET g_errparam.extend = "Max_Row:"||g_max_rec USING "<<<<<"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF

      END FOREACH
      
      
   
   CALL g_apcb1_d.deleteElement(g_cnt)
   
   LET g_rec_b1 = g_cnt - 1
   LET g_cnt = 0

   FREE apcb_pre2
      
END FUNCTION
################################################################################
# Descriptions...: 抓取其他帳套資料
# Memo...........:
# Usage..........: afap200_open_s01(p_flag,p_apcb002,p_apcb003)
#                   
# Input parameter:  
#                :  
# Return code....:  
#                :  
# Date & Author..: 2014/02/28 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_open_s01(p_flag,p_apcb002,p_apcb003)
DEFINE p_flag LIKE type_t.chr1
DEFINE li_idx1 LIKE type_t.num5
DEFINE p_apcb002 LIKE apcb_t.apcbdocno
DEFINE p_apcb003 LIKE apcb_t.apcbseq
DEFINE lwin_curr       ui.Window
DEFINE lfrm_curr       ui.Form
DEFINE ls_path STRING
DEFINE l_str   STRING  #160426-00014#15 add


   #開啟畫面
   OPEN WINDOW w_afap200_s01 WITH FORM cl_ap_formpath("afa","afap200_s01")
   CALL cl_ui_init()
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   #160426-00014#15 add s---
   IF g_master.f = '1' THEN
      CALL cl_set_comp_visible('apca100,apcb103,apcb105,apcb113,apcb115',TRUE)
      LET l_str = cl_getmsg("afa-01146",g_lang)  
      CALL cl_set_comp_att_text('apca004',l_str) 
      LET l_str = cl_getmsg("afa-01147",g_lang)  
      CALL cl_set_comp_att_text('apca004_desc_1',l_str) 
      LET l_str = cl_getmsg("afa-01148",g_lang)  
      CALL cl_set_comp_att_text('apcb005',l_str)                
   ELSE
      CALL cl_set_comp_visible('apca100,apcb103,apcb105,apcb113,apcb115',FALSE)  
      LET l_str = cl_getmsg("afa-01145",g_lang)  
      CALL cl_set_comp_att_text('apca004',l_str)  
      LET l_str = cl_getmsg("sub-01386",g_lang)  
      CALL cl_set_comp_att_text('apca004_desc_1',l_str)  
      LET l_str = cl_getmsg("adb-00384",g_lang)  
      CALL cl_set_comp_att_text('apcb005',l_str) 
   END IF
   #160426-00014#15 add e---
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
         INPUT ARRAY g_apcb1_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b1,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = TRUE)
         
            BEFORE INPUT 
               CALL afap200_apcb_1_fill(p_apcb002,p_apcb003)
               LET g_rec_b1 = g_apcb1_d.getLength()
#               CALL cl_set_comp_entry("apcald,apcbdocno,apcbseq,apcadocdt,apca004,apca100,apcb103,apcb105,apcb113,apcb115",FALSE) 
               
            BEFORE ROW
               LET g_detail_idx1 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac1 = ARR_CURR()
               
           
            ON CHANGE check
               IF g_apcb1_d[l_ac1].check = 'N' THEN 
                  UPDATE afap200_tmp01 SET apcald_1 = 'N'      # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
                   WHERE apcbdocno = g_apcb1_d[l_ac1].apcbdocno_1
                     AND apcald = g_apcb1_d[l_ac1].apcald_1
                     AND apcbseq = g_apcb1_d[l_ac1].apcbseq_1
                ELSE
                  UPDATE afap200_tmp01 SET apcald_1 = 'Y'       # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
                   WHERE apcbdocno = g_apcb1_d[l_ac1].apcbdocno_1
                     AND apcald = g_apcb1_d[l_ac1].apcald_1 
                     AND apcbseq = g_apcb1_d[l_ac1].apcbseq_1
                END IF                
            
            #選擇全部         
            ON ACTION check_all_1
               CALL DIALOG.setSelectionRange("s_detail2", 1, -1, 1)
               FOR li_idx1 = 1 TO g_apcb1_d.getLength()
                   LET g_apcb1_d[li_idx1].check = "Y"
               END FOR
               UPDATE afap200_tmp01 SET apcald_1 = 'Y'      # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
                  WHERE apcbdocno = p_apcb002
                    AND apcbseq = p_apcb003                  
            
            #選擇全不選
            ON ACTION check_no_all_1   
               CALL DIALOG.setSelectionRange("s_detail2", 1, -1, 1)
               FOR li_idx1 = 1 TO g_apcb1_d.getLength()
                   LET g_apcb1_d[li_idx1].check = "N"
               END FOR
               UPDATE afap200_tmp01 SET apcald_1 = 'N'    # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
                WHERE apcbdocno = p_apcb002
                  AND apcbseq = p_apcb003     
             
                  
         END INPUT
         
         ON ACTION accept
            ACCEPT DIALOG
            
         ON ACTION CLOSE #直接關閉窗口時默認原先產生其他帳套的狀態，都為選擇狀態
            CALL DIALOG.setSelectionRange("s_detail2", 1, -1, 1)
            FOR li_idx1 = 1 TO g_apcb1_d.getLength()
                LET g_apcb1_d[li_idx1].check = "Y"
            END FOR
            UPDATE afap200_tmp01 SET apcald_1 = 'Y'     # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
             WHERE apcbdocno = p_apcb002
              AND apcbseq = p_apcb003  
            LET INT_FLAG = 0
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = 0
            EXIT DIALOG
            
         ON ACTION Cancel  #取消默認原先產生其他帳套的狀態，都為選擇狀態
            CALL DIALOG.setSelectionRange("s_detail2", 1, -1, 1)
            FOR li_idx1 = 1 TO g_apcb1_d.getLength()
                LET g_apcb1_d[li_idx1].check = "Y"
            END FOR
            UPDATE afap200_tmp01 SET apcald_1 = 'Y'    # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
             WHERE apcbdocno = p_apcb002
               AND apcbseq = p_apcb003  
            LET INT_FLAG = 0
            EXIT DIALOG
     END DIALOG    
     
     #畫面關閉
     CLOSE WINDOW w_afap200_s01     
                            
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL afap200_create_tmp()
#                   
# Input parameter:  
#                :  
# Return code....:  
#                :  
# Date & Author..: 2014/2/26 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_create_tmp()
   DROP TABLE afap200_tmp01           # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
   DROP TABLE afap200_tmp02        # 160727-00019#1 Mod  afap200_apcb_tmp --> afap200_tmp02
   
   #20150506--mark--str--lujh
   #CREATE TEMP TABLE afap200_tmp01   # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
   #(
   #apcald_1     VARCHAR(1),    #是否選擇
   #apcald       VARCHAR(5),
   #apcald_desc  VARCHAR(80),
   #apcbdocno    VARCHAR(20),
   #apcbseq      DECIMAL(10,0),
   #apcadocdt    DATE,
   #apca004      VARCHAR(10),
   #apca004_desc VARCHAR(80),
   #apca100      VARCHAR(10),
   #apcb004      VARCHAR(20),
   #apcb005      VARCHAR(80),
   #apcb103      DECIMAL(20,6),
   #apcb105      DECIMAL(20,6),
   #apcb113      DECIMAL(20,6),
   #apcb115      DECIMAL(20,6),
   #apcb002      VARCHAR(20),
   #apcb003      DECIMAL(10,0)
   # );   
   # 
   #CREATE TEMP TABLE  afap200_tmp02        # 160727-00019#1 Mod  afap200_apcb_tmp --> afap200_tmp02
   #(
   #b            VARCHAR(1),
   #apcbld       VARCHAR(5),
   #apcbld_desc  VARCHAR(80),
   #apcbdocno    VARCHAR(20),
   #apcbseq      DECIMAL(10,0),
   #apcadocdt    DATE,
   #apca004      VARCHAR(10),
   #apca004_desc VARCHAR(80),
   #apca100      VARCHAR(10),
   #apcb004      VARCHAR(20),
   #apcb005      VARCHAR(80),
   #apcb007      DECIMAL(20,6),
   #apcb103      DECIMAL(20,6),
   #apcb105      DECIMAL(20,6),
   #apcb113      DECIMAL(20,6),
   #apcb115      DECIMAL(20,6),
   #apcb015      VARCHAR(10),
   #apcb016      VARCHAR(30),
   #t            VARCHAR(10),
   #faah002      DECIMAL(10,0),
   #faah001      VARCHAR(10),
   #faah003      VARCHAR(10),
   #faah004      VARCHAR(5),
   #faah006      VARCHAR(10),
   #faah007      VARCHAR(10),
   #faah027      VARCHAR(10),
   #c            VARCHAR(1)
   # );
   #20150506--mark--end--lujh    
    
    
   CREATE TEMP TABLE afap200_tmp01(    # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
   apcald_1     LIKE type_t.chr1,    #是否選擇
   apcald       LIKE apca_t.apcald,
   apcald_desc  LIKE type_t.chr80,
   apcbdocno    LIKE apcb_t.apcbdocno,
   apcbseq      LIKE apcb_t.apcbseq,
   apcadocdt    LIKE apca_t.apcadocdt,
   apca004      LIKE apca_t.apca004,
   apca004_desc LIKE type_t.chr80,
   apca100      LIKE apca_t.apca100,
   apcb004      LIKE apcb_t.apcb004,
   apcb005      LIKE apcb_t.apcb005,
   imaal004     LIKE imaal_t.imaal004,   #160426-00014#15 add
   apcb103      LIKE apcb_t.apcb103,
   apcb105      LIKE apcb_t.apcb105,
   apcb113      LIKE apcb_t.apcb113,
   apcb115      LIKE apcb_t.apcb115,
   apcb002      LIKE apcb_t.apcb002,
   apcb003      LIKE apcb_t.apcb003
    );    

   CREATE TEMP TABLE afap200_tmp02(       # 160727-00019#1 Mod  afap200_apcb_tmp --> afap200_tmp02
   b            LIKE type_t.chr1,
   apcbld       LIKE apcb_t.apcbld,
   apcbld_desc  LIKE type_t.chr80,
   apcbdocno    LIKE apcb_t.apcbdocno,
   apcbseq      LIKE apcb_t.apcbseq,
   apcadocdt    LIKE apca_t.apcadocdt,
   apca004      LIKE apca_t.apca004,
   apca004_desc LIKE type_t.chr80,
   apca100      LIKE apca_t.apca100,
   apcb004      LIKE apcb_t.apcb004,
   apcb005      LIKE apcb_t.apcb005,
   imaal004     LIKE imaal_t.imaal004,  #160426-00014#15 add
   inbb010      LIKE inbb_t.inbb010,    #160426-00014#15 add
   oocal003     LIKE oocal_t.oocal003,  #160426-00014#15 add   
   apcb007      LIKE apcb_t.apcb007,
   xccc280      LIKE xccc_t.xccc280,    #160426-00014#15 add 
   xccc280_inbb011 LIKE xccc_t.xccc280, #160426-00014#15 add    
   apcb103      LIKE apcb_t.apcb103,
   apcb105      LIKE apcb_t.apcb105,
   apcb113      LIKE apcb_t.apcb113,
   apcb115      LIKE apcb_t.apcb115,
   apcb015      LIKE apcb_t.apcb015,
   apcb016      LIKE apcb_t.apcb016,
   apcb047      LIKE apcb_t.apcb047, #161019-00042#1 add 
   t            LIKE type_t.chr10,
   faah002      LIKE faah_t.faah002,
   faah001      LIKE faah_t.faah001,
   faah003      LIKE faah_t.faah003,
   faah004      LIKE faah_t.faah004,
   faah006      LIKE faah_t.faah006,
   faah007      LIKE faah_t.faah007,
   faah027      LIKE faah_t.faah027,
   c            LIKE type_t.chr1,
   #albireo 160111-----s
   l_oofg001_t1  LIKE type_t.chr100,
   l_before_code LIKE type_t.chr100,
   l_num_code    LIKE type_t.chr100,
   l_after_code  LIKE type_t.chr100
   #albireo 160111-----e
    );      
END FUNCTION
################################################################################
# Descriptions...: 插入faaj臨時表資料
# Memo...........:
# Usage..........: CALL afap200_get_faaj_tmp(p_wc,p_apcbdocno)
#                   
# Input parameter:  
#                :  
# Return code....:  
#                :  
# Date & Author..: 2014/2/28 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_get_faaj_tmp(p_wc,p_apcbdocno)
   DEFINE p_wc              STRING
   DEFINE l_sql             STRING
   DEFINE p_apcbdocno       LIKE apcb_t.apcbdocno
   DEFINE l_apcb002         LIKE apcb_t.apcb002
   DEFINE l_apcb003         LIKE apcb_t.apcb003   
  
   
   LET p_wc = p_wc.trim() 
   IF cl_null(p_wc) THEN   
      LET p_wc = " 1=1 "
   END IF
 
    

#   LET l_sql= " SELECT '',apcald,'',apcbdocno,apcbseq,apcadocdt,apca004,'',apca100,apcb103,apcb105,apcb113,apcb115,apcb002,apcb003",                
#              "   FROM apcb_t LEFT OUTER JOIN apca_t ON apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
#              "               LEFT OUTER JOIN glaa_t ON glaaent = apcbent AND glaald = apcbld ",
#              "  WHERE apcbent = '",g_enterprise,"' AND apcacomp = '",g_master.ooef001,"' ",
##              "    AND glaa014 = 'N' ",                   
#              "    AND ",p_wc,
#              "    AND apcastus = 'Y' ",
#              
#              "  ORDER BY apcbld,apcadocdt "
IF g_master.f = '1' THEN #160426-00014#15 add 
   #LET l_sql= " SELECT '',glaald,'',apcbdocno,apcbseq,apcadocdt,apca004,'',apca100,apcb004,apcb005,apcb103,apcb105,apcb113,apcb115,apcb002,apcb003 ",  #160426-00014#15 mark 
   LET l_sql= " SELECT '',glaald,(SELECT glaal002 FROM glaal_t WHERE glaalent=",g_enterprise," AND glaalld=glaald AND glaal001='",g_lang,"'),apcbdocno,apcbseq,apcadocdt,apca004,(SELECT pmaal004 FROM pmaal_t WHERE pmaalent=",g_enterprise," AND pmaal001=apca004 AND pmaal002='",g_lang,"'),",  #160426-00014#15 add  
              "        apca100,apcb004,apcb005,'',apcb103,apcb105,apcb113,apcb115,apcb002,apcb003 ", #160426-00014#15 add
              "   FROM glaa_t,apcb_t LEFT OUTER JOIN apca_t ON apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
              "  WHERE apcbent = '",g_enterprise,"'",
              "    AND apcacomp = '",g_master.ooef001,"'",
#              "    AND apcbsite = '",g_master.fabgsite,"'",
              "    AND apcbld = '",g_master.glaald,"'",
              "    AND NOT EXISTS (SELECT 1 FROM faah_t WHERE faah040=apcbdocno AND faahent=",g_enterprise," AND faah045=apcbseq AND faah040 <>' ')", #160905-00007#1 add
              "    AND NOT EXISTS (SELECT 1 FROM faak_t WHERE faak041=apcbdocno AND faakent=",g_enterprise," AND faak044=apcbseq AND faak041 <>' ')", #160905-00007#1 add
#              "    AND (apcadocno NOT IN (SELECT faah040 FROM faah_t,apcb_t WHERE faah040=apcbdocno AND faah045=apcbseq AND faah040 <>' ') ",
#              "     OR apcbseq NOT IN (SELECT faah045 FROM faah_t,apcb_t WHERE faah040=apcbdocno AND faah045=apcbseq AND faah040 <>' ') )",
#              "    AND (apcadocno NOT IN (SELECT faak041 FROM faak_t,apcb_t WHERE faak041=apcbdocno AND faak044=apcbseq AND faak041 <>' ')" ,
#              "     OR apcbseq NOT IN (SELECT faak044 FROM faak_t,apcb_t WHERE faak041=apcbdocno AND faak044=apcbseq AND faak041 <>' ') )" ,             
              "    AND glaaent = apcbent ",
              "    AND glaacomp = '",g_master.ooef001,"'",
              "    AND glaa014 = 'N' ",
              "    AND (apca016 <> '15' OR apca016 IS NULL) ",
              "    AND ",p_wc,
              "    AND apcastus = 'Y' ",
              "    AND (apcb001 IN('11','12','13','14','16','17','18','19') OR apcb001 IS NULL)",
              "    AND (apca001 IN('01','03','11','13','14','15','16','17','19','31')) ",
              "    AND apcb023 = 'N' ",
              "  ORDER BY apcbdocno,apcbseq,apcadocdt,apca004 "
#160426-00014#15 add s---             
ELSE
   LET p_wc = cl_replace_str(p_wc,"apca005","''")
   LET p_wc = cl_replace_str(p_wc,"apca","inba")
   LET p_wc = cl_replace_str(p_wc,"apcb","inbb")
   LET l_sql= " SELECT '',glaald,(SELECT glaal002 FROM glaal_t WHERE glaalent=",g_enterprise," AND glaalld=glaald AND glaal001='",g_lang,"'),inbbdocno,inbbseq,inbadocdt,inba003,(SELECT ooag011 FROM ooag_t WHERE ooagent = ",g_enterprise," AND ooag001 = inba003),",
              "        '',inbb001,(SELECT imaal003 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = inbb001 AND imaal002 = '",g_dlang,"'),",
              "        (SELECT imaal004 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = inbb001 AND imaal002 = '",g_dlang,"'),'','','','','' ",             
              "   FROM glaa_t,inbb_t LEFT OUTER JOIN inba_t ON inbaent = inbbent AND inbadocno = inbbdocno ",
              "  WHERE inbbent = '",g_enterprise,"'",
                 "    AND inbasite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef017 ='",g_master.ooef001,"')",
                 "    AND inba001 = '1'",#雜發
              "    AND NOT EXISTS (SELECT 1 FROM faah_t WHERE faah057=inbbdocno AND faahent=",g_enterprise," AND faah058=inbbseq AND faah040 <>' ')",  
              "    AND NOT EXISTS (SELECT 1 FROM faak_t WHERE faak047=inbbdocno AND faakent=",g_enterprise," AND faak045=inbbseq AND faak041 <>' ')",        
              "    AND glaaent = inbbent ",
              "    AND glaacomp = '",g_master.ooef001,"'",
              "    AND glaa014 = 'N' ",
              "    AND ",p_wc,
              "    AND inbastus = 'S' ",
              "  ORDER BY inbbdocno,inbbseq,inbadocdt,inba003 "   
END IF
#160426-00014#15 add e---
              
   PREPARE apcb_pre1 FROM l_sql
   DECLARE apcb_cur1 CURSOR FOR apcb_pre1

    
   LET g_cnt = 1
   FOREACH apcb_cur1 INTO g_tmp.*,l_apcb002,l_apcb003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach1:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET g_tmp.check = "Y"

#160426-00014#15 mark s---
#      #獲取帳套名稱    
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_tmp.apcald_1
#      CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_lang||"'","") RETURNING g_rtn_fields
#      LET g_tmp.apcald_desc_1 = '', g_rtn_fields[1] , ''
#    
#      #獲取帳款客戶簡稱
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_tmp.apca004_1
#      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_lang||"'","") RETURNING g_rtn_fields
#      LET g_tmp.apca004_desc_1 = '', g_rtn_fields[1] , ''
#160426-00014#15 mark e---  
      
#      INSERT INTO afap200_tmp01(apcald_1,apcald,apcald_desc,apcbdocno,apcbseq,apcadocdt,apca004,apca004_desc,   # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
#                                   apca100,apcb103,apcb105,apcb113,apcb115,apcb002,apcb003) 
#           VALUES(g_tmp.check,g_tmp.apcald_1,g_tmp.apcald_desc_1,g_tmp.apcbdocno_1,g_tmp.apcbseq_1,g_tmp.apcadocdt_1,
#                  g_tmp.apca004_1,g_tmp.apca004_desc_1,g_tmp.apca100_1,g_tmp.apcb103_1,g_tmp.apcb105_1,
#                  g_tmp.apcb113_1,g_tmp.apcb115_1,l_apcb002,l_apcb003)
      INSERT INTO afap200_tmp01(apcald_1,apcald,apcald_desc,apcbdocno,apcbseq,apcadocdt,apca004,apca004_desc,    # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
#                                   apca100,apcb004,apcb005,apcb103,apcb105,apcb113,apcb115,apcb002,apcb003)     #160426-00014#15 mark
                                   apca100,apcb004,apcb005,imaal004,apcb103,apcb105,apcb113,apcb115,apcb002,apcb003)  #160426-00014#15 add
           VALUES(g_tmp.check,g_tmp.apcald_1,g_tmp.apcald_desc_1,g_tmp.apcbdocno_1,g_tmp.apcbseq_1,g_tmp.apcadocdt_1,
#                  g_tmp.apca004_1,g_tmp.apca004_desc_1,g_tmp.apca100_1,g_tmp.apcb004_1,g_tmp.apcb005_1,g_tmp.apcb103_1,g_tmp.apcb105_1,  #160426-00014#15 mark
                  g_tmp.apca004_1,g_tmp.apca004_desc_1,g_tmp.apca100_1,g_tmp.apcb004_1,g_tmp.apcb005_1,g_tmp.imaal004_1,g_tmp.apcb103_1,g_tmp.apcb105_1, #160426-00014#15 add
                  g_tmp.apcb113_1,g_tmp.apcb115_1,l_apcb002,l_apcb003)     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "afap200_tmp01"    # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         EXIT FOREACH
      END IF
      END FOREACH
      
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap200_ui_dialog_1()
# Date & Author..: 2014/7/29 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_ui_dialog_1()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num5
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   DEFINE lb_first  BOOLEAN
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE l_origin_str           STRING 
   
   #add-point:ui_dialog段define
   DEFINE l_cnt    LIKE type_t.num5
   DEFINE l_flag   LIKE type_t.chr1
   DEFINE l_check  LIKE type_t.chr1
   DEFINE g_apcbdocno_t LIKE apcb_t.apcbdocno
   DEFINE l_apcb002 LIKE apcb_t.apcb002
   DEFINE l_apcb003 LIKE apcb_t.apcb003
   DEFINE l_n       LIKE type_t.num5
   DEFINE l_success LIKE type_t.num5
   DEFINE l_count   LIKE type_t.num5
   DEFINE l_count1  LIKE type_t.num5
   
   #150311---earl---add---s
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
                   oofg019     LIKE oofg_t.oofg019,   #field
                   oofg020     LIKE oofg_t.oofg020    #value
                           END RECORD
   #150311---earl---add---e   
   
   CALL afap200_create_tmp()
   CALL cl_set_comp_visible("b,b_c",TRUE)
   WHILE TRUE
      #add-point:ui_dialog段before dialog2

      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
                
         INPUT ARRAY g_apcb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = TRUE)
         
         BEFORE INPUT
            CALL cl_set_comp_visible("check_all,check_no_all,other_check_no_all,other_check_all",FALSE)
            #CALL afap200_apcb_fill(g_wc2) #160426-00014#15 mark
            DELETE FROM afap200_tmp01     # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
            CALL afap200_get_faaj_tmp(g_wc2,'')  #查詢出符合條件的主帳套，并將所有其他帳套資料插入臨時表
            LET g_rec_b = g_apcb_d.getLength()
            IF g_rec_b = 0 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = "-100"
               LET g_errparam.popup  = TRUE
               CALL cl_err()            
               EXIT DIALOG 
            END IF 
#           CALL cl_set_comp_entry("apcbdocno,apcbseq,apcadocdt,apca004,apca100,apcb004,apcb005,apcb103,apcb105,apcb113,apcb115,apcb015,apcb016,t",FALSE)
            IF g_master.a = 'Y' THEN   #在建工程，產生其他帳套及選擇act隱藏
               CALL cl_set_comp_visible("b_c",FALSE)
            ELSE
               CALL cl_set_comp_visible("b_c",TRUE)
            END IF
            
         BEFORE ROW
            LET l_ac = ARR_CURR()
            #add by yangxf -----
            IF g_apcb_d[l_ac].faah002 = '1' THEN     
               CALL cl_set_comp_entry("b_faah004",FALSE)
            ELSE
               CALL cl_set_comp_entry("b_faah004",TRUE)
            END IF
            IF g_apcb_d[l_ac].b = 'N' THEN 
               CALL cl_set_comp_entry("b_faah001,b_faah002,b_faah003,b_faah004,b_faah006,b_faah007,b_faah027,b_c",FALSE)
            ELSE
               CALL cl_set_comp_entry("b_faah001,b_faah002,b_faah003,b_faah004,b_faah006,b_faah007,b_faah027,b_c",TRUE)
            END IF 
            IF g_rec_b >= l_ac THEN 
               LET g_apcb_d_t.* = g_apcb_d[l_ac].*
            END IF 
            #add by yangxf ----
            
         #chenying add--str-- 
         ON CHANGE b
            IF g_apcb_d[l_ac].b = 'N' THEN 
               LET g_apcb_d[l_ac].faah002 = ''
               LET g_apcb_d[l_ac].faah003 = ''
               LET g_apcb_d[l_ac].faah004 = ''
               LET g_apcb_d[l_ac].faah006 = ''
               LET g_apcb_d[l_ac].faah007 = ''
               LET g_apcb_d[l_ac].faah027 = ''
               LET g_apcb_d[l_ac].c = 'N'
               UPDATE afap200_tmp01 SET apcald_1 = 'N'    # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
                WHERE apcbdocno = g_apcb_d[l_ac].apcbdocno
                  AND apcbseq = g_apcb_d[l_ac].apcbseq  
               CALL cl_set_comp_entry("b_faah001,b_faah002,b_faah003,b_faah004,b_faah006,b_faah007,b_faah027,b_c",FALSE)
            ELSE
               CALL cl_set_comp_entry("b_faah001,b_faah002,b_faah003,b_faah004,b_faah006,b_faah007,b_faah027,b_c",TRUE)
               LET g_apcb_d[l_ac].faah002 = '1'
               LET g_apcb_d[l_ac].faah003 = ''
               LET g_apcb_d[l_ac].faah004 = ' '
               CALL cl_set_comp_entry("b_faah004",FALSE)
            END IF 
         
         #20141123 在建工程时项目编号及WBS需为必录项
         AFTER FIELD apcb015
            IF NOT cl_null(g_apcb_d[l_ac].apcb015) THEN
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_apcb_d[l_ac].apcb015
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apj-00012:sub-01302|apjm200|",cl_get_progname("apjm200",g_lang,"2"),"|:EXEPROGapjm200"
               #160318-00025#5--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjba001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                   
               ELSE
                  #檢查失敗時後續處理
                  LET g_apcb_d[l_ac].apcb015 =''
                  NEXT FIELD CURRENT
               END IF
            END IF
            
         AFTER FIELD apcb016

                IF NOT cl_null(g_apcb_d[l_ac].apcb016) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_apcb_d[l_ac].apcb015
                  LET g_chkparam.arg2 = g_apcb_d[l_ac].apcb016
                  
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_pjbb002") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  
                  ELSE
                     #檢查失敗時後續處理
                     LET g_apcb_d[l_ac].apcb016 = ''
                     NEXT FIELD CURRENT
                  END IF                         
               END IF  
               
         #160426-00014#15 add s---
         AFTER FIELD xccc280
            IF cl_null(g_apcb_d[l_ac].xccc280) THEN LET g_apcb_d[l_ac].xccc280 = 0 END IF
            LET g_apcb_d[l_ac].xccc280_inbb011 = g_apcb_d[l_ac].xccc280*g_apcb_d[l_ac].apcb007
            DISPLAY BY NAME g_apcb_d[l_ac].apcb007
         #160426-00014#15 add e---         
  
         #add by yangxf begin----
         BEFORE FIELD b_faah002
            IF cl_null(g_apcb_d[l_ac].faah002) THEN 
               LET g_apcb_d[l_ac].faah002 = '1'
               LET g_apcb_d[l_ac].faah003 = ''
               LET g_apcb_d[l_ac].faah004 = ' '
               CALL cl_set_comp_entry("b_faah004",FALSE)
            END IF 
         
         ON CHANGE b_faah002
            IF g_apcb_d[l_ac].faah002 = '1' THEN 
               LET g_apcb_d[l_ac].faah003 = ''
               LET g_apcb_d[l_ac].faah004 = ' '
               CALL cl_set_comp_entry("b_faah004",FALSE)
            ELSE
               LET g_apcb_d[l_ac].faah003 = ''
               LET g_apcb_d[l_ac].faah004 = ''
               CALL cl_set_comp_entry("b_faah004",TRUE)
            END IF 
            IF g_para_data2 = 'Y' AND g_apcb_d[l_ac].faah002 = '1' THEN
               CALL cl_set_comp_entry("b_faah003",FALSE)               
               LET g_apcb_d[l_ac].faah003 = g_apcb_d[l_ac].faah001
               IF g_apcb_d[l_ac].faah002 != g_apcb_d_t.faah002 OR cl_null(g_apcb_d_t.faah002) THEN 
                  IF NOT cl_null(g_apcb_d[l_ac].faah001) AND NOT cl_null(g_apcb_d[l_ac].faah003) AND g_apcb_d[l_ac].faah004 IS NOT NULL THEN 
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND " || "faah001 = '"||g_apcb_d[l_ac].faah001 ||"' AND "|| "faah003 = '"||g_apcb_d[l_ac].faah003 ||"' AND "|| "faah004 = '"||g_apcb_d[l_ac].faah004 ||"'",'std-00004',0) THEN  
                        LET g_apcb_d[l_ac].faah002 = ''
                        NEXT FIELD b_faah002
                     END IF
                     LET l_n = 0
                     SELECT COUNT(*) INTO l_n
                       FROM afap200_tmp02  a            # 160727-00019#1 Mod  afap200_apcb_tmp --> afap200_tmp02
                      WHERE NOT EXISTS (SELECT * FROM afap200_tmp02  b    # 160727-00019#1 Mod  afap200_apcb_tmp --> afap200_tmp02
                                         WHERE a.apcbdocno = g_apcb_d[l_ac].apcbdocno
                                           AND a.apcbseq = g_apcb_d[l_ac].apcbseq
                                           AND a.apcbdocno = b.apcbdocno
                                           AND a.apcbseq = b.apcbseq)
                        AND faah003 = g_apcb_d[l_ac].faah003
                        AND faah004 = g_apcb_d[l_ac].faah004
                        AND faah001 = g_apcb_d[l_ac].faah001
                     IF l_n > 0 THEN 
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = '' 
                        LET g_errparam.code   = 'std-00004'
                        LET g_errparam.popup  = FALSE 
                        CALL cl_err()
                        NEXT FIELD b_faah002
                     END IF 
                  END IF
               END IF
            ELSE
               CALL cl_set_comp_entry("b_faah003",TRUE)    
            END IF

         AFTER FIELD b_faah001
            IF g_para_data = 'N' THEN
               SELECT lpad(g_apcb_d[l_ac].faah001,10,'0') INTO g_apcb_d[l_ac].faah001
                 FROM faah_t
                WHERE faahent = g_enterprise
            END IF 
            IF g_para_data2 = 'Y' THEN
               IF NOT cl_null(g_apcb_d[l_ac].faah001) AND g_apcb_d[l_ac].faah002 = '1' THEN                
                  LET g_apcb_d[l_ac].faah003 = g_apcb_d[l_ac].faah001
                  DISPLAY BY NAME g_apcb_d[l_ac].faah003
                  CALL cl_set_comp_entry("b_faah003",FALSE)
               END IF
            ELSE
               CALL cl_set_comp_entry("b_faah003",TRUE)
            END IF               
            IF NOT cl_null(g_apcb_d[l_ac].faah001) AND NOT cl_null(g_apcb_d[l_ac].faah003) AND g_apcb_d[l_ac].faah004 IS NOT NULL THEN 
                IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND "|| "faah001 = '"||g_apcb_d[l_ac].faah001 ||"' AND "|| "faah003 = '"||g_apcb_d[l_ac].faah003 ||"' AND "|| "faah004 = '"||g_apcb_d[l_ac].faah004 ||"'",'std-00004',0) THEN 
                   NEXT FIELD CURRENT
                END IF
                LET l_n = 0
                SELECT COUNT(*) INTO l_n
                  FROM afap200_tmp02 a    # 160727-00019#1 Mod  afap200_apcb_tmp --> afap200_tmp02
                 WHERE NOT EXISTS (SELECT * FROM afap200_tmp02 b    # 160727-00019#1 Mod  afap200_apcb_tmp --> afap200_tmp02
                                    WHERE a.apcbdocno = g_apcb_d[l_ac].apcbdocno
                                      AND a.apcbseq = g_apcb_d[l_ac].apcbseq
                                      AND a.apcbdocno = b.apcbdocno
                                      AND a.apcbseq = b.apcbseq)
                   AND faah003 = g_apcb_d[l_ac].faah003
                   AND faah004 = g_apcb_d[l_ac].faah004
                   AND faah001 = g_apcb_d[l_ac].faah001
                IF l_n > 0 THEN 
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = '' 
                   LET g_errparam.code   = 'std-00004'
                   LET g_errparam.popup  = FALSE 
                   CALL cl_err()
                   NEXT FIELD b_faah001
                END IF 
            END IF 
            
            
         BEFORE FIELD b_faah003
            IF cl_null(g_apcb_d[l_ac].faah003) AND g_apcb_d[l_ac].faah002 = '1' THEN
               IF g_para_data2 <> 'Y' THEN
                  IF g_para_data3 = 'Y' THEN
                     
                    # IF g_master.a = 'N' THEN     #151008-00017#2 add            151008-00017#3 mark       
                        #150311---earl---mod---s
                        #CALL s_aooi390('3') RETURNING l_success,g_apcb_d[l_ac].faah003
#                        CALL s_aooi390_auto_no('3') RETURNING l_success,g_apcb_d[l_ac].faah003,l_oofg_return
                        #CALL s_aooi390_gen('3') RETURNING l_success,g_apcb_d[l_ac].faah003,l_oofg_return   #add--2015/07/01 By shiun  #151225-00014#1 mark
                        #150311---earl---mod---e
                        
                        #151225-00014#1-----s
                           ##albireo 160111-----s
                           ##自動編碼後要將必要4欄位存入record方便之後INSER TEMP
                           #LET g_apcb_d[l_ac].l_oofg001_t1  = g_oofg001_t1 CLIPPED
                           #LET g_apcb_d[l_ac].l_before_code = g_before_code CLIPPED
                           #LET g_apcb_d[l_ac].l_num_code    = g_num_code CLIPPED
                           #LET g_apcb_d[l_ac].l_after_code  = g_after_code CLIPPED
                      
                        CALL s_aooi390_gen_for_successive_1('3') 
                             RETURNING l_success,g_apcb_d[l_ac].faah003,l_oofg_return, 
                                       g_apcb_d[l_ac].l_oofg001_t1, 
                                       g_apcb_d[l_ac].l_before_code, 
                                       g_apcb_d[l_ac].l_num_code, 
                                       g_apcb_d[l_ac].l_after_code                        
                        
                        DISPLAY BY NAME g_apcb_d[l_ac].l_oofg001_t1,g_apcb_d[l_ac].l_before_code,
                                        g_apcb_d[l_ac].l_num_code,g_apcb_d[l_ac].l_after_code
                           #albrieo 160111-----e
                        #151225-00014#1-----e
                        
                   #  END IF   #151008-00017#2 add   151008-00017#3 mark
                     
                     DISPLAY BY NAME g_apcb_d[l_ac].faah003
                  END IF 
               END IF 
            END IF
         
         #財编检查
         AFTER FIELD b_faah003
            IF  NOT cl_null(g_apcb_d[l_ac].faah001) AND NOT cl_null(g_apcb_d[l_ac].faah003) AND g_apcb_d[l_ac].faah004 IS NOT NULL THEN
                ##151225-00014#1-----s 
                IF NOT cl_null(g_apcb_d[l_ac].faah003) THEN 
                   CALL s_aooi390_chk_for_successive('3',g_apcb_d[l_ac].faah003, 
                                                     g_apcb_d[l_ac].l_oofg001_t1, 
                                                     g_apcb_d[l_ac].l_before_code, 
                                                     g_apcb_d[l_ac].l_num_code, 
                                                     g_apcb_d[l_ac].l_after_code) 
                        RETURNING l_success,g_apcb_d[l_ac].l_oofg001_t1, 
                                            g_apcb_d[l_ac].l_before_code, 
                                            g_apcb_d[l_ac].l_num_code, 
                                            g_apcb_d[l_ac].l_after_code 
                
                END IF 
                ##151225-00014#1-----e 
                
                
                IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND "|| "faah001 = '"||g_apcb_d[l_ac].faah001 ||"' AND "|| "faah003 = '"||g_apcb_d[l_ac].faah003 ||"' AND "|| "faah004 = '"||g_apcb_d[l_ac].faah004 ||"'",'std-00004',0) THEN 
                   NEXT FIELD CURRENT
                END IF
                LET l_n = 0
                SELECT COUNT(*) INTO l_n
                  FROM afap200_tmp02 a     # 160727-00019#1 Mod  afap200_apcb_tmp --> afap200_tmp02
                 WHERE NOT EXISTS (SELECT * FROM afap200_tmp02 b    # 160727-00019#1 Mod  afap200_apcb_tmp --> afap200_tmp02
                                    WHERE a.apcbdocno = g_apcb_d[l_ac].apcbdocno
                                      AND a.apcbseq = g_apcb_d[l_ac].apcbseq
                                      AND a.apcbdocno = b.apcbdocno
                                      AND a.apcbseq = b.apcbseq)
                   AND faah003 = g_apcb_d[l_ac].faah003
                   AND faah004 = g_apcb_d[l_ac].faah004
                   AND faah001 = g_apcb_d[l_ac].faah001
                IF l_n > 0 THEN 
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = '' 
                   LET g_errparam.code   = 'std-00004'
                   LET g_errparam.popup  = FALSE 
                   CALL cl_err()
                   NEXT FIELD b_faah003
                END IF 
               
                
             #   IF g_master.a = 'N' THEN   #151008-00017#2 add   151008-00017#3 mark
             
                   ##151225-00014#1-----s 
                   CALL s_aooi390_chk_for_successive('3',g_apcb_d[l_ac].faah003, 
                                                     g_apcb_d[l_ac].l_oofg001_t1, 
                                                     g_apcb_d[l_ac].l_before_code, 
                                                     g_apcb_d[l_ac].l_num_code, 
                                                     g_apcb_d[l_ac].l_after_code) 
                        RETURNING l_success,g_apcb_d[l_ac].l_oofg001_t1, 
                                            g_apcb_d[l_ac].l_before_code, 
                                            g_apcb_d[l_ac].l_num_code, 
                                            g_apcb_d[l_ac].l_after_code 
                   ##151225-00014#1-----e 
             
                   #add--2015/07/01 By shiun--(S)
                   
                   ###151225-00014#1 MARK-----s
                   ##albireo 160111-----s
                   #LET g_oofg001_t1 = g_apcb_d[l_ac].l_oofg001_t1  
                   #LET g_before_code = g_apcb_d[l_ac].l_before_code 
                   #LET g_num_code = g_apcb_d[l_ac].l_num_code    
                   #LET g_after_code = g_apcb_d[l_ac].l_after_code  
                   ##albireo 160111-----e
                   #IF NOT s_aooi390_chk('3',g_apcb_d[l_ac].faah003) THEN
                   #   LET g_apcb_d[l_ac].faah003 = ''
                   #   #albireo 160111-----s
                   #   #財蝙沒值 清空設定
                   #   IF cl_null(g_apcb_d[l_ac].faah003)THEN
                   #      LET g_apcb_d[l_ac].l_oofg001_t1  = ''
                   #      LET g_apcb_d[l_ac].l_before_code = ''
                   #      LET g_apcb_d[l_ac].l_num_code    = ''
                   #      LET g_apcb_d[l_ac].l_after_code  = ''
                   #      DISPLAY BY NAME g_apcb_d[l_ac].l_oofg001_t1,g_apcb_d[l_ac].l_before_code,
                   #                      g_apcb_d[l_ac].l_num_code,g_apcb_d[l_ac].l_after_code
                   #   END IF
                   #   #albireo 160111-----e
                   #   DISPLAY BY NAME g_apcb_d[l_ac].faah003
                   #   NEXT FIELD CURRENT
                   #ELSE
                   #   #albireo 160111-----s
                   #   LET g_apcb_d[l_ac].l_oofg001_t1  = g_oofg001_t1 
                   #   LET g_apcb_d[l_ac].l_before_code = g_before_code
                   #   LET g_apcb_d[l_ac].l_num_code    = g_num_code   
                   #   LET g_apcb_d[l_ac].l_after_code  = g_after_code 
                   #   DISPLAY BY NAME g_apcb_d[l_ac].l_oofg001_t1,g_apcb_d[l_ac].l_before_code,
                   #                      g_apcb_d[l_ac].l_num_code,g_apcb_d[l_ac].l_after_code
                   #   #albireo 160111-----e
                   #END IF
                   ##add--2015/07/01 By shiun--(E)
             #     #END IF   #151008-00017#2 add    151008-00017#3 mark
                   ###151225-00014#1 MARK-----s
                
            END IF
            IF NOT cl_null(g_apcb_d[l_ac].faah003) THEN 
               IF NOT afap200_faah003_chk() THEN 
                  LET g_apcb_d[l_ac].faah003 = ''
                  #albireo 160111-----s
                  #財蝙沒值 清空設定
                  IF cl_null(g_apcb_d[l_ac].faah003)THEN
                     LET g_apcb_d[l_ac].l_oofg001_t1  = ''
                     LET g_apcb_d[l_ac].l_before_code = ''
                     LET g_apcb_d[l_ac].l_num_code    = ''
                     LET g_apcb_d[l_ac].l_after_code  = ''
                     DISPLAY BY NAME g_apcb_d[l_ac].l_oofg001_t1,g_apcb_d[l_ac].l_before_code,
                                     g_apcb_d[l_ac].l_num_code,g_apcb_d[l_ac].l_after_code
                  END IF
                  #albireo 160111-----e
                  NEXT FIELD b_faah003
               END IF 

            END IF 
            #2015/02/15 Add By 01727 客户家财产编号Key值,重复需要提醒,但不需要卡死
            #2015/02/15 Add ---(S)---
            IF g_para_data3 != 'Y'  THEN  #160324-00036#1 add
               IF NOT cl_null(g_apcb_d[l_ac].faah003) AND NOT cl_null(g_apcb_d[l_ac].faah002) AND g_apcb_d[l_ac].faah002 = '1' THEN  #类型为主件时候才需要判断
                  LET l_count = 0
                  SELECT COUNT(*) INTO l_count FROM faah_t WHERE faahent = g_enterprise
                     AND faah003 = g_apcb_d[l_ac].faah003
                  IF cl_null(l_count) THEN lET l_count = 0 END IF
                  FOR l_count1 = 1 TO g_apcb_d.getLength()
                     IF g_apcb_d[l_ac].faah003 = g_apcb_d[l_count1].faah003 AND l_ac <> l_count1 THEN
                        LET l_count = l_count + 1
                     END IF
                  END FOR
                  IF l_count > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-00449'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  END IF
               END IF
            END IF   #160324-00036#1 add
            #2015/02/15 Add ---(E)---
            
            #albireo 160111-----s
            #財蝙沒值 清空設定
            IF cl_null(g_apcb_d[l_ac].faah003)THEN
               LET g_apcb_d[l_ac].l_oofg001_t1  = ''
               LET g_apcb_d[l_ac].l_before_code = ''
               LET g_apcb_d[l_ac].l_num_code    = ''
               LET g_apcb_d[l_ac].l_after_code  = ''
               DISPLAY BY NAME g_apcb_d[l_ac].l_oofg001_t1,g_apcb_d[l_ac].l_before_code,
                               g_apcb_d[l_ac].l_num_code,g_apcb_d[l_ac].l_after_code
            END IF
            #albireo 160111-----e
         
         BEFORE FIELD b_faah004
            IF g_apcb_d[l_ac].faah002 = '1' THEN 
               LET g_apcb_d[l_ac].faah004 = ' '
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 'afa-00317'
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
            END IF 
         
         AFTER FIELD b_faah004
            IF  NOT cl_null(g_apcb_d[l_ac].faah001) AND NOT cl_null(g_apcb_d[l_ac].faah003) AND NOT cl_null(g_apcb_d[l_ac].faah004) THEN
                IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND "|| "faah001 = '"||g_apcb_d[l_ac].faah001 ||"' AND "|| "faah003 = '"||g_apcb_d[l_ac].faah003 ||"' AND "|| "faah004 = '"||g_apcb_d[l_ac].faah004 ||"'",'std-00004',0) THEN 
                   NEXT FIELD CURRENT
                END IF
                LET l_n = 0
                SELECT COUNT(*) INTO l_n
                  FROM afap200_tmp02 a  # 160727-00019#1 Mod  afap200_apcb_tmp --> afap200_tmp02
                 WHERE NOT EXISTS (SELECT * FROM afap200_tmp02 b  # 160727-00019#1 Mod  afap200_apcb_tmp --> afap200_tmp02
                                    WHERE a.apcbdocno = g_apcb_d[l_ac].apcbdocno
                                      AND a.apcbseq = g_apcb_d[l_ac].apcbseq
                                      AND a.apcbdocno = b.apcbdocno
                                      AND a.apcbseq = b.apcbseq)
                   AND faah003 = g_apcb_d[l_ac].faah003
                   AND faah004 = g_apcb_d[l_ac].faah004
                   AND faah001 = g_apcb_d[l_ac].faah001
                IF l_n > 0 THEN 
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = '' 
                   LET g_errparam.code   = 'std-00004'
                   LET g_errparam.popup  = FALSE 
                   CALL cl_err()
                   NEXT FIELD b_faah004
                END IF 
            END IF
            IF g_apcb_d[l_ac].faah002 = '1' THEN 
               LET g_apcb_d[l_ac].faah004 = ' '
            END IF 
            
         AFTER FIELD b_faah006
            IF NOT cl_null(g_apcb_d[l_ac].faah006) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_apcb_d[l_ac].faah006
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00007:sub-01302|afai020|",cl_get_progname("afai020",g_lang,"2"),"|:EXEPROGafai020"
               #160318-00025#5--add--end
               IF cl_chk_exist("v_faac001") THEN
                  #161125-00017#1 add s---
                  LET g_sql = " SELECT COUNT(1) FROM faal_t WHERE faalent = '",g_enterprise,"' AND faalld = '",g_master.glaald,"' AND faal001 = '",g_apcb_d[l_ac].faah006,"'"
                  PREPARE afap200_faah006_count FROM g_sql
                  EXECUTE afap200_faah006_count INTO l_cnt   
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF                  
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01123'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apcb_d[l_ac].faah006 = ''
                     NEXT FIELD CURRENT  
                  END IF
                  #161125-00017#1 add e---
               ELSE
                  #檢查失敗時後續處理
                  LET g_apcb_d[l_ac].faah006 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            
         AFTER FIELD b_faah007
            IF NOT cl_null(g_apcb_d[l_ac].faah007) THEN
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_apcb_d[l_ac].faah007
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00009:sub-01302|afai030|",cl_get_progname("afai030",g_lang,"2"),"|:EXEPROGafai030"
               #160318-00025#5--add--end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faad001") THEN
               ELSE
                  #檢查失敗時後續處理
                  LET g_apcb_d[l_ac].faah007 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            
        AFTER FIELD b_faah027
            IF NOT cl_null(g_apcb_d[l_ac].faah027) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_apcb_d[l_ac].faah027
               IF cl_chk_exist("v_oocq002_3900") THEN
                  #161125-00017#1 add s---    
                  SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.glaald                  
                  SELECT COUNT(1) INTO l_cnt FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '3900' 
                     AND oocq002 = g_apcb_d[l_ac].faah027 AND (oocq004 = g_glaacomp OR oocq004 IS NULL)  
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01120'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apcb_d[l_ac].faah027 = ''
                     NEXT FIELD CURRENT                  
                  END IF  
                  #161125-00017#1 add e---
               ELSE
                  LET g_apcb_d[l_ac].faah027 = ''
                  NEXT FIELD CURRENT
               END IF

            END IF        
            
            
         AFTER ROW 
            IF g_apcb_d[l_ac].b = 'Y' THEN 
               IF cl_null(g_apcb_d[l_ac].faah002) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 'afa-00315'
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  NEXT FIELD b_faah002
               END IF 
               IF g_apcb_d[l_ac].faah003 IS NULL THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 'afa-00315'
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  NEXT FIELD b_faah003
               END IF 
               IF g_apcb_d[l_ac].faah002 = '1' THEN 
                  IF g_apcb_d[l_ac].faah004 IS NULL THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = 'afa-00315'
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                     NEXT FIELD b_faah004
                  END IF 
               ELSE
                  IF cl_null(g_apcb_d[l_ac].faah004) THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = 'afa-00315'
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                     NEXT FIELD b_faah004
                  END IF 
               END IF 
               IF cl_null(g_apcb_d[l_ac].faah006) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 'afa-00315'
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  NEXT FIELD b_faah006
               END IF 
              # IF cl_null(g_apcb_d[l_ac].faah007) THEN 
              #    INITIALIZE g_errparam TO NULL 
              #    LET g_errparam.extend = '' 
              #    LET g_errparam.code   = 'afa-00315'
              #    LET g_errparam.popup  = FALSE 
              #    CALL cl_err()
              #    NEXT FIELD b_faah007
              # END IF 
            END IF 
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               EXIT DIALOG 
            END IF
               #albireo 160111 add l_oofg001_t1,l_before_code,l_num_code,l_after_code
               UPDATE afap200_tmp02 SET (b,apcb015,apcb016,t,faah002,faah001,    # 160727-00019#1 Mod  afap200_apcb_tmp --> afap200_tmp02
                                            faah003,faah004,faah006,faah007,faah027,c,
                                            l_oofg001_t1,l_before_code,l_num_code,l_after_code,apcb007,xccc280_inbb011)=( #160426-00014#15 add  apcb007,xccc280_inbb011  
                                            g_apcb_d[l_ac].b,g_apcb_d[l_ac].apcb015,g_apcb_d[l_ac].apcb016,g_apcb_d[l_ac].t,g_apcb_d[l_ac].faah002,g_apcb_d[l_ac].faah001,
                                            g_apcb_d[l_ac].faah003,g_apcb_d[l_ac].faah004,g_apcb_d[l_ac].faah006,g_apcb_d[l_ac].faah007,g_apcb_d[l_ac].faah027,g_apcb_d[l_ac].c,
                                            g_apcb_d[l_ac].l_oofg001_t1,g_apcb_d[l_ac].l_before_code,g_apcb_d[l_ac].l_num_code,g_apcb_d[l_ac].l_after_code,
                                            g_apcb_d[l_ac].apcb007,g_apcb_d[l_ac].xccc280_inbb011 #160426-00014#15 add
                                            )
                WHERE apcbdocno = g_apcb_d[l_ac].apcbdocno
                  AND apcbseq = g_apcb_d[l_ac].apcbseq
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "afap200_tmp02"   # 160727-00019#1 Mod  afap200_apcb_tmp --> afap200_tmp02
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "afap200_tmp02"   # 160727-00019#1 Mod  afap200_apcb_tmp --> afap200_tmp02
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  OTHERWISE
               END CASE 
               
               
         ON ACTION controlp INFIELD b_faah003
            IF g_apcb_d[l_ac].faah002 = '2' OR g_apcb_d[l_ac].faah002 = '3' THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_apcb_d[l_ac].faah003
               LET g_qryparam.where = " faah032 = '",g_master.ooef001,"'"
               CALL q_faah003()
               LET g_apcb_d[l_ac].faah003 = g_qryparam.return1
               NEXT FIELD b_faah003                          #返回原欄位
            END IF
            
         ON ACTION controlp INFIELD b_faah006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_d[l_ac].faah006
            #161125-00017#1 add s---
            #CALL q_faac001()		   
            LET g_qryparam.where = " faalld = '",g_master.glaald,"'"  
            CALL q_faal001_1()          
            #161125-00017#1 add e--- 
            LET g_apcb_d[l_ac].faah006 = g_qryparam.return1
            DISPLAY g_apcb_d[l_ac].faah006 TO b_faah006
            NEXT FIELD b_faah006

         ON ACTION controlp INFIELD b_faah007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_d[l_ac].faah007
            CALL q_faad001()
            LET g_apcb_d[l_ac].faah007 = g_qryparam.return1
            DISPLAY g_apcb_d[l_ac].faah007 TO b_faah007
            NEXT FIELD b_faah007
         #add by yangxf end-----

         #20141124 add--str--
         ON ACTION controlp INFIELD b_apcb015
            #add-point:ON ACTION controlp INFIELD fabh034_desc
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_apcb_d[l_ac].apcb015            #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjba001()                                #呼叫開窗

            LET g_apcb_d[l_ac].apcb015 = g_qryparam.return1              

            DISPLAY g_apcb_d[l_ac].apcb015 TO b_apcb015             #

            NEXT FIELD b_apcb015                            #返回原欄位    
            
         ON ACTION controlp INFIELD b_apcb016
            #add-point:ON ACTION controlp INFIELD fabh034_desc
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_apcb_d[l_ac].apcb016            #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_apcb_d[l_ac].apcb015
            CALL q_pjbb002_1()                                #呼叫開窗
            LET g_apcb_d[l_ac].apcb016 = g_qryparam.return1
            DISPLAY g_apcb_d[l_ac].apcb016 TO b_apcb016
            NEXT FIELD b_apcb016                            #返回原欄位           

         ON ACTION controlp INFIELD b_faah027
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_d[l_ac].faah027  
            LET g_qryparam.arg1 = '3900'
            #161125-00017#1 add s---
            SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.glaald
            LET g_qryparam.where = " (oocq004 = '",g_glaacomp,"' OR oocq004 IS NULL)"
            #161125-00017#1 add e---            
            CALL q_oocq002()
            LET g_apcb_d[l_ac].faah027 = g_qryparam.return1
            DISPLAY g_apcb_d[l_ac].faah027 TO b_faah027
            NEXT FIELD b_faah027    
         #20141124 add--end--
         
         #chenying add--end--          
         ON CHANGE b_c
            #默認都不勾選
            IF g_apcb_d[l_ac].b = 'Y' THEN  #在[選擇]按鈕勾選的前提下   
#               #通過應付帳款單據+項次獲取對應來源業務單+項次
#               SELECT apcb002,apcb003 INTO l_apcb002,l_apcb003
#                 FROM apcb_t
#                WHERE apcbdocno = g_apcb_d[l_ac].apcbdocno
#                  AND apcbseq = g_apcb_d[l_ac].apcbseq 
                         
               IF g_apcb_d[l_ac].c = "Y" THEN  
                 #異動[產生其他帳套]
                 #mark by yangxf
                 #Y時，更新臨時表中check狀態為Y
#                 UPDATE afap200_tmp01 SET apcald_1 = 'Y'  # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
#                  WHERE apcb002 = l_apcb002
#                    AND apcb003 = l_apcb003
#                mark by yangxf
                 #add by yangxf
                 LET l_n = 0
                 SELECT COUNT(*) INTO l_n
                   FROM apca_t
                  WHERE apcadocno = g_apcb_d[l_ac].apcbdocno
                    AND apca001 = '19'
                    AND apcaent= g_enterprise #160905-00007#1 add
                 IF l_n > 0 THEN 
                    LET g_apcb_d[l_ac].c = "N"
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'afa-00318'
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    NEXT FIELD b_c
                 END IF 
                 UPDATE afap200_tmp01 SET apcald_1 = 'Y'    # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
                  WHERE apcbdocno = g_apcb_d[l_ac].apcbdocno
                    AND apcbseq = g_apcb_d[l_ac].apcbseq 
                 #add by yangxf
                 CALL afap200_open_s01(g_flag,g_apcb_d[l_ac].apcbdocno,g_apcb_d[l_ac].apcbseq )   
              ELSE
                 #modify by yangxf
                 #N時，更新臨時表中check狀態為N
#                 UPDATE afap200_tmp01 SET apcald_1 = 'N'     # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
#                  WHERE apcbd002 = l_apcb002
#                    AND apcb003 = l_apcb003            
                 UPDATE afap200_tmp01 SET apcald_1 = 'N'      # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
                  WHERE apcbdocno = g_apcb_d[l_ac].apcbdocno
                    AND apcbseq = g_apcb_d[l_ac].apcbseq     
                 #modify by yangxf
              END IF 
            ELSE
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'afa-00040'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()

              LET g_apcb_d[l_ac].c = 'N'
            END IF
     
         #全选         
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_apcb_d.getLength()
               LET g_apcb_d[li_idx].b = "Y"
               UPDATE afap200_tmp02 SET b=g_apcb_d[li_idx].b   # 160727-00019#1 Mod  afap200_apcb_tmp --> afap200_tmp02
                WHERE apcbdocno = g_apcb_d[li_idx].apcbdocno
                  AND apcbseq = g_apcb_d[li_idx].apcbseq
            END FOR
            CALL cl_set_comp_entry("b_faah001,b_faah002,b_faah003,b_faah004,b_faah006,b_faah007,b_faah027,b_c",TRUE)

         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_apcb_d.getLength()
               LET g_apcb_d[li_idx].b = "N"
               LET g_apcb_d[li_idx].faah002 = ''
               LET g_apcb_d[li_idx].faah003 = ''
               LET g_apcb_d[li_idx].faah004 = ''
               LET g_apcb_d[li_idx].faah006 = ''
               LET g_apcb_d[li_idx].faah007 = ''
               LET g_apcb_d[li_idx].faah027 = ''
               LET g_apcb_d[li_idx].c = 'N'
               UPDATE afap200_tmp01 SET apcald_1 = 'N'   # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
                WHERE apcbdocno = g_apcb_d[li_idx].apcbdocno
                  AND apcbseq = g_apcb_d[li_idx].apcbseq 
                  
#               UPDATE afap200_tmp02 SET (b,apcb015,apcb016,t,faah002,faah001,    # 160727-00019#1 Mod  afap200_apcb_tmp--> afap200_tmp02
#                                            faah003,faah004,faah006,faah007,faah027,c)=(
#                                            g_apcb_d[li_idx].b,g_apcb_d[li_idx].apcb015,g_apcb_d[li_idx].apcb016,g_apcb_d[li_idx].t,g_apcb_d[li_idx].faah002,g_apcb_d[li_idx].faah001,
#                                            g_apcb_d[li_idx].faah003,g_apcb_d[li_idx].faah004,g_apcb_d[li_idx].faah006,g_apcb_d[li_idx].faah007,g_apcb_d[li_idx].faah027,g_apcb_d[li_idx].c)
#                WHERE apcbdocno = g_apcb_d[li_idx].apcbdocno
#                  AND apcbseq = g_apcb_d[li_idx].apcbseq

               #albireo 160111 add l_oofg001_t1,l_before_code,l_num_code,l_after_code
               UPDATE afap200_tmp02 SET (b,apcb015,apcb016,t,faah002,faah001,   # 160727-00019#1 Mod  afap200_apcb_tmp--> afap200_tmp02
                                            faah003,faah004,faah006,faah007,faah027,c,
                                            l_oofg001_t1,l_before_code,l_num_code,l_after_code,apcb007,xccc280_inbb011)=(     #160426-00014#15 add apcb007,xccc280_inbb011     
                                            g_apcb_d[l_ac].b,g_apcb_d[l_ac].apcb015,g_apcb_d[l_ac].apcb016,g_apcb_d[l_ac].t,g_apcb_d[l_ac].faah002,g_apcb_d[l_ac].faah001,
                                            g_apcb_d[l_ac].faah003,g_apcb_d[l_ac].faah004,g_apcb_d[l_ac].faah006,g_apcb_d[l_ac].faah007,g_apcb_d[l_ac].faah027,g_apcb_d[l_ac].c,
                                            g_apcb_d[l_ac].l_oofg001_t1,g_apcb_d[l_ac].l_before_code,g_apcb_d[l_ac].l_num_code,g_apcb_d[l_ac].l_after_code,
                                            g_apcb_d[l_ac].apcb007,g_apcb_d[l_ac].xccc280_inbb011 #160426-00014#15 add
                                            )
                WHERE apcbdocno = g_apcb_d[l_ac].apcbdocno
                  AND apcbseq = g_apcb_d[l_ac].apcbseq
            END FOR
            CALL cl_set_comp_entry("b_faah001,b_faah002,b_faah003,b_faah004,b_faah006,b_faah007,b_faah027,b_c",FALSE)

            INITIALIZE lc_param.* TO NULL
            
         #選擇產生其他帳套全部
         #[產生其他帳套全選]時,默認含稅
         ON ACTION other_check_all
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_apcb_d.getLength()
               LET g_apcb_d[li_idx].c = "Y"
            END FOR
            #全選時，更新臨時表中check狀態為Y
            UPDATE afap200_tmp01 SET apcald_1 = 'Y'    # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
            
         #選擇產生其他帳套全不選
         ON ACTION other_check_no_all
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_apcb_d.getLength()
               LET g_apcb_d[li_idx].c = "N"
            END FOR  
            #全不選時，更新臨時表中check狀態為N             
            UPDATE afap200_tmp01 SET apcald_1 = 'N'  # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01

         #產生底稿
         ON ACTION faak_ins
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            
            #詢問以原幣本幣未稅OR原幣本幣含稅生成主帳套或多帳套的卡片成本   

         AFTER INPUT 
            IF NOT INT_FLAG THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM afap200_tmp02    # 160727-00019#1 Mod  afap200_apcb_tmp--> afap200_tmp02
                WHERE b = 'Y'
                  AND faah002 IS NULL
               IF l_n > 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00358'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD b
               END IF 
               CALL afap200_detail_display()
            END IF 
         
         END INPUT  
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL cl_qbe_display_condition(FGL_GETENV("QUERYPLANID"), g_user)
            CALL afap200_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog
            CALL cl_set_comp_visible("check_all,check_no_all,other_check_no_all,other_check_all",FALSE)
            CALL afap200_construct()
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF 
            CALL afap200_apcb_fill(g_wc2)
            NEXT FIELD b
            #end add-point
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL afap200_get_buffer(l_dialog)
            IF NOT cl_null(ls_wc) THEN
               LET lc_param.wc = ls_wc
               #取得條件後需要執行項目,應新增於下方adp
               #add-point:ui_dialog段qbe_select後

               #end add-point
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
#         ON ACTION batch_execute
#            ACCEPT DIALOG
 
         ON ACTION qbeclear   
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         #add-point:ui_dialog段action
         ON ACTION accept
            ACCEPT DIALOG
        
         ON ACTION cancel
            LET INT_FLAG = 0
            EXIT DIALOG 
            
         ON ACTION query
            CALL afap200_construct()
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF 
            CALL afap200_apcb_fill(g_wc2)
            
            NEXT FIELD b
         #end add-point
 
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #add-point:ui_dialog段exit dialog
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF 
      #end add-point
 

   END WHILE
   
END FUNCTION

################################################################################
# Descriptions...: 资产中心说明
# Memo...........:
# Usage..........: CALL afap200_get_fabgsite_desc()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/12/01 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_get_fabgsite_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.fabgsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.fabgsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.fabgsite_desc
END FUNCTION

################################################################################
# Descriptions...: 帐套说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/12/01 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_get_glaald_desc()
      #獲取主帳套名稱    
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_master.glaald
      CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_master.glaald_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_master.glaald_desc
END FUNCTION

################################################################################
# Descriptions...: 获取主帐套
# Memo...........:
# Usage..........: CALL afap200_glaald_get()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/12/01 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_glaald_get()
   SELECT glaald INTO g_master.glaald
     FROM glaa_t
    WHERE glaacomp = g_master.ooef001
      AND glaa014 = 'Y'
      AND glaaent=g_enterprise #160905-00007#1 add
   DISPLAY BY NAME g_master.glaald
END FUNCTION

################################################################################
# Descriptions...: 资产中心与法人检查
# Memo...........:
# Usage..........: CALL afap200_site_comp_chk(p_site,p_comp)
# Input parameter: p_site         资产中心 
#                : p_comp         法人
# Return code....: r_success
# Date & Author..: 2014/11/27 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_site_comp_chk(p_site,p_comp)
DEFINE p_site      LIKE faba_t.fabasite
DEFINE p_comp      LIKE faba_t.fabacomp
DEFINE l_sql       STRING
DEFINE l_count     LIKE type_t.num5
DEFINE l_origin_str  STRING

  LET g_errno = ''
  CALL s_fin_create_account_center_tmp()
  CALL s_fin_account_center_sons_query('5',p_site,g_today,'1')
  CALL s_fin_account_center_comp_str() RETURNING l_origin_str
  CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
  LET l_origin_str = "(",l_origin_str,")"
  LET l_sql = " SELECT COUNT(*) FROM ooef_t ",
              "  WHERE ooefent = '",g_enterprise,"' AND ooef017='",p_comp,"'",
              "    AND ooef001 IN ",l_origin_str
   PREPARE sel_fabacomp FROM l_sql
   EXECUTE sel_fabacomp INTO l_count
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      LET g_errno = 'afa-00306'
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()   
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 组SQL条件
# Memo...........:
# Usage..........: CALL s_afat502_change_to_sql(p_wc)
#                  RETURNING r_wc
# Input parameter: p_wc           条件
# Return code....: r_wc           条件
# Date & Author..: 2014/11/27 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_change_to_sql(p_wc)
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
# Descriptions...: 单身資料顯示
# Memo...........:
# Usage..........: CALL afap200_detail_display()
# Input parameter:  
# Date & Author..: 2014/12/2 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_detail_display()
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   
   DISPLAY ARRAY g_apcb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b)

      BEFORE ROW
          LET l_ac = DIALOG.getCurrentRow("s_detail1")
          LET g_detail_idx = l_ac
          DISPLAY g_detail_idx TO h_index

       BEFORE DISPLAY
          CALL cl_set_act_visible("accept,cancel", FALSE)
          CALL FGL_SET_ARR_CURR(g_detail_idx)
          LET l_ac = DIALOG.getCurrentRow("s_detail1")
          DISPLAY g_rec_b TO h_count
 
   
      ON ACTION close
         LET g_action_choice="exit"
         LET INT_FLAG=FALSE         
         EXIT DISPLAY
         
      ON ACTION exit
         LET g_action_choice="exit"
         LET INT_FLAG = FALSE
         EXIT DISPLAY
         
      ON ACTION batch_execute
         LET ls_js = util.JSON.stringify(lc_param)
         IF g_chk_jobid THEN 
            LET g_jobid = g_schedule.gzpa001
         ELSE 
            LET g_jobid = cl_schedule_get_jobid(g_prog)
         END IF 
         CASE 
            WHEN g_schedule.gzpa003 = "0"
                 CALL afap200_process(ls_js)
                 LET INT_FLAG = 0
                 EXIT DISPLAY
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = afap200_transfer_argv(ls_js)
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
         INITIALIZE lc_param.*  TO NULL 
         
         #欄位初始資訊 
         CALL cl_schedule_init_info("all",g_schedule.gzpa003) 
         LET gi_hiden_asign = FALSE 
         LET gi_hiden_exec = FALSE 
         LET gi_hiden_spec = FALSE 
         LET gi_hiden_exec_end = FALSE 
         CALL cl_schedule_hidden()
         LET INT_FLAG = 0
         EXIT DISPLAY 
   END DISPLAY    
END FUNCTION

################################################################################
# Descriptions...: 產生其他帳套
# Memo...........:
# Usage..........: afap200_ins_faaj(p_faah001,p_faah003,p_apcb002,p_apcb003,p_apcb015,p_apcb016)
#                  
# Input parameter:  
#                :  
# Return code....:  
#                :  
# Date & Author..: 2014/2/28 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_ins_faaj(p_faah003,p_apcb002,p_apcb003,p_apcb015,p_apcb016)
   DEFINE l_sql             STRING
   DEFINE p_faah003         LIKE faah_t.faah003 
   DEFINE l_max_faaj001     LIKE faaj_t.faaj001
   DEFINE l_glaa015         LIKE glaa_t.glaa015
   DEFINE l_glaa019         LIKE glaa_t.glaa019
   DEFINE l_apcb123         LIKE apcb_t.apcb123
   DEFINE l_apcb125         LIKE apcb_t.apcb125
   DEFINE l_apcb133         LIKE apcb_t.apcb133
   DEFINE l_apcb135         LIKE apcb_t.apcb135
   DEFINE l_glab002         LIKE glab_t.glab002
   DEFINE p_apcb002         LIKE apcb_t.apcbdocno
   DEFINE p_apcb003         LIKE apcb_t.apcbseq
   DEFINE l_max1            LIKE type_t.chr10
   DEFINE l_ym              LIKE type_t.chr10
   DEFINE l_yy              LIKE type_t.num5
   DEFINE l_mm              LIKE type_t.num5
   DEFINE l_cy              LIKE type_t.chr4
   DEFINE l_cm              LIKE type_t.chr2  
   DEFINE l_t1              LIKE type_t.chr80 
   DEFINE l_glaa022         LIKE glaa_t.glaa022 
   DEFINE l_glaa018         LIKE glaa_t.glaa018 
   DEFINE l_glaa025         LIKE glaa_t.glaa025   
   DEFINE l_glaa017         LIKE glaa_t.glaa017 
   DEFINE l_glaa021         LIKE glaa_t.glaa021
   DEFINE p_apcb015         LIKE apcb_t.apcb015
   DEFINE p_apcb016         LIKE apcb_t.apcb016
   DEFINE l_year            LIKE type_t.num5
   DEFINE l_month           LIKE type_t.num5
   DEFINE l_num1            LIKE type_t.num5
   DEFINE l_num2            LIKE type_t.num5
   DEFINE l_str             STRING
   DEFINE l_str1            STRING
   DEFINE l_str2            STRING
   DEFINE l_faac016         LIKE faac_t.faac016
   DEFINE l_fristdate       LIKE faah_t.faah014     #161223-00055#1 add lujh

   LET l_sql= " SELECT apcald_1,apcald,apcald_desc,apcbdocno,apcbseq,apcadocdt,apca004,apca004_desc,apca100,apcb103,apcb105,apcb113,apcb115",                
              "   FROM afap200_tmp01 ",    # 160727-00019#1 Mod  afap200_faaj_tmp--> afap200_tmp01
              "  WHERE apcbdocno = '",p_apcb002,"' ",
              "    AND apcbseq = ",p_apcb003,
              "    AND apcald_1 = 'Y' ",   #抓取有【選擇】的資料 
              "  ORDER BY apcald,apcbdocno "
              
            
   PREPARE apcb_pre3 FROM l_sql
   DECLARE apcb_cur3 CURSOR FOR apcb_pre3
      
   FOREACH apcb_cur3 INTO g_faaj_1.*
     IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach3:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
     LET g_faaj.faajent = g_enterprise 
     LET g_faaj.faajld = g_faaj_1.apcald_1
     LET g_faaj.faaj001 = p_faah003  #財產編號
     LET g_faaj.faajsite = g_site
     
     #批號
     #LET g_faaj.faaj037 = g_faah.faah000  #160426-00014#15 mark
     LET g_faaj.faaj037 = g_faah.faah001 #160426-00014#15 add
     
#      LET l_yy = YEAR(g_today)
#      LET l_mm = MONTH(g_today) 
#      LET l_cy = l_yy USING '&&&&'
#      LET l_cm = l_mm USING '&&'
#      LET l_ym = l_cy,l_cm
#      LET l_t1 = ''
#      LET l_max1 = ''
#      SELECT MAX(faaj000) INTO l_max1 FROM faaj_t   #非在建
#      IF cl_null(l_t1) THEN 
#         IF NOT cl_null(l_max1) THEN
#            SELECT MAX(faaj000) INTO l_max1 FROM faaj_t   
#            #最大批號是否與當前年月匹配
#            IF l_max1[1,6] MATCHES l_ym THEN   
#               LET g_faaj.faaj000 = l_max1 + 1 USING '&&&&&&&&&&'  #匹配則在最大批號基礎上加1 
#            ELSE
#               LET g_faaj.faaj000 = l_ym,'1' USING '&&&&'         #不匹配則按當前年月組合批號      
#            END IF         
#         ELSE
#            LET g_faaj.faaj000 = l_ym,'1' USING '&&&&'            
#         END IF
#         LET l_t1 =  g_faaj.faaj000
#      ELSE
#         LET g_faaj.faaj000 = l_t1 + 1 USING '&&&&&&&&&&' 
#         LET l_t1 = g_faaj.faaj000
#      END IF       
      
#     #暫定財產編號
#     IF cl_null(g_faaj.faaj001) THEN 
#         SELECT MAX(faaj001) INTO l_max_faaj001 FROM faaj_t
#      ELSE
#         LET l_max_faaj001 = g_faaj.faaj001    
#      END IF    
#      IF l_max_faaj001 IS NULL THEN LET l_max_faaj001 =0 END IF
#      LET g_faaj.faaj001 =l_max_faaj001+1 USING '&&&&&&&&&&' 
      
 
     LET g_faaj.faaj002 = ' ' #附號
#     LET g_faaj.faaj005 = 0 #未使用年限
#     LET g_faaj.faaj009 = 0 #最近折舊年度
#     LET g_faaj.faaj010 = 0 #最近折舊期別
   #  LET g_faaj.faaj014 = g_faaj_1.apca100_1
     LET g_faaj.faaj017 = 0 #累折
     LET g_faaj.faaj019 = 0 #預留殘值
     LET g_faaj.faaj020 = 0 #調整成本
     LET g_faaj.faaj038 = 0 #160426-00014#15 add
      #add by yangxf ---
      LET g_faaj.faaj117 = 0
      LET g_faaj.faaj113 = 0
      LET g_faaj.faaj114 = 0
      LET g_faaj.faaj115 = 0
      LET g_faaj.faaj110 = 0
      LET g_faaj.faaj112 = 0
      LET g_faaj.faaj167 = 0
      LET g_faaj.faaj163 = 0
      LET g_faaj.faaj164 = 0
      LET g_faaj.faaj165 = 0
      LET g_faaj.faaj160 = 0
      LET g_faaj.faaj162 = 0
      #抓取本月入帳提列方式
      SELECT faal005,faal006 INTO g_faal005,g_faaj.faaj048  #161129-00048#1 add faaj048列帳/列管 
        FROM faal_t
       WHERE faalent = g_enterprise
         AND faalld  = g_faaj.faajld
         AND faal001 = g_faah.faah006
      
      LET l_year = YEAR(g_faah.faah014)
      LET l_month = MONTH(g_faah.faah014)
      
      #161223-00055#1--mark--str--lujh
      #IF g_faal005 = '1' THEN
      #   LET l_num2 = l_month + 1
      #   IF l_num2 > 12 THEN
      #      LET l_num2 = 1
      #      LET l_num1 = l_year + 1
      #   ELSE
      #      LET l_num2 = l_num2
      #      LET l_num1 = l_year
      #   END IF
      #ELSE
      #   LET l_num1 = l_year
      #   LET l_num2 = l_month
      #END IF
      #161223-00055#1--mark--end--lujh
      
      #161223-00055#1--add--str--lujh
      IF g_faal005 = '1' THEN 
         LET l_num2 = l_month + 1
         IF l_num2 > 12 THEN 
            LET l_num2 = 1
            LET l_num1 = l_year + 1
         ELSE
            LET l_num2 = l_num2
            LET l_num1 = l_year
         END IF
      END IF 
      IF g_faal005 = '2' OR g_faal005 = '4' THEN 
         LET l_num1 = l_year
         LET l_num2 = l_month
      END IF
      IF g_faal005 = '3' THEN
         CALL s_date_get_first_date(g_faah.faah014) RETURNING l_fristdate
         LET l_fristdate = l_fristdate + 14
         IF g_faah.faah014 <= l_fristdate THEN 
            LET l_num1 = l_year
            LET l_num2 = l_month
         ELSE
            LET l_num2 = l_month + 1
            IF l_num2 > 12 THEN 
               LET l_num2 = 1
               LET l_num1 = l_year + 1
            ELSE
               LET l_num2 = l_num2
               LET l_num1 = l_year
            END IF
         END IF 
      END IF 
      #161223-00055#1--add--end--lujh
      
      LET l_str1 = l_num1
      LET l_str2 = l_num2
      IF l_num2 < 10 THEN
         LET l_str = l_str1 CLIPPED,'0' CLIPPED,l_str2 CLIPPED
      ELSE
         LET l_str = l_str1 CLIPPED,l_str2 CLIPPED
      END IF
      LET g_faaj.faaj008 = l_str.trim()
      #add by yangxf --- 
     IF g_master.f = 1 THEN #160426-00014#15 add  
        LET g_faaj.faaj030 = g_faaj_1.apcbdocno_1  #應付單據
     END IF   #160426-00014#15 add  
     LET g_faaj.faaj031 = g_faaj_1.apcbseq_1 #帳款編號項次
     LET g_faaj.faajownid = g_user  #資料所有者
     LET g_faaj.faajowndp = g_dept #資料所屬部門
     LET g_faaj.faajcrtid = g_user  #資料建立者
     LET g_faaj.faajcrtdp = g_dept #資料建立部門
     LET g_faaj.faajcrtdt = g_today #資料創建日
     LET g_faaj.faajstus = 'N'      #狀態碼
     LET g_faaj.faaj022 =0 
     LET g_faaj.faaj017=0
     LET g_faaj.faaj018=0
     LET g_faaj.faaj033=0
     LET g_faaj.faaj034=0
     LET g_faaj.faaj035=0
     LET g_faaj.faaj032=0
     LET g_faaj.faaj027=0
     LET g_faaj.faaj021=0     
     LET g_faaj.faaj042=g_faaj_1.apca004_1
     LET g_faaj.faaj043=g_faaj_1.apca004_1
     LET g_faaj.faaj045 = p_apcb015
     LET g_faaj.faaj046 = p_apcb016
     #本位币、匯率類型
      SELECT glaa001,glaa025 INTO g_faaj.faaj014,l_glaa025
       FROM glaa_t  
      WHERE glaaent = g_enterprise
        AND glaald = g_faaj.faajld 
      #本位幣 匯率  
      CALL s_aooi160_get_exrate('2',g_faaj.faajld,g_faaj_1.apcadocdt_1,g_faaj_1.apca100_1,   #161221-00072#1 change g_today to  g_faaj_1.apcadocdt_1 lujh 
                                   #目的幣別                 #匯類類型
                                   g_faaj.faaj014,0,l_glaa025)
         RETURNING g_faaj.faaj015  
         
      #成本   
      LET g_faaj.faaj016 = g_faah.faah022 * g_faaj.faaj015
      LET g_faaj.faaj028 = g_faaj.faaj016 #未折減額
      
#     #資產科目
#     #借方科目為默認資產科目
#     SELECT apcb021 INTO g_faaj.faaj023 FROM apcb_t
#      WHERE apcbent = g_enterprise 
#        AND apcbld = g_faaj_1.apcald_1
#        AND apcbdocno = g_faaj_1.apcbdocno_1
#        AND apcbseq = g_faaj_1.apcbseq_1       #在get_faaj_tmp的時候暫沒指定項次
#     #借方科目為空時，抓取應付貸方科目   
#     IF cl_null(g_faaj.faaj023) THEN
#        SELECT apca035 INTO g_faaj.faaj023 FROM apca_t
#         WHERE apcaent = g_enterprise 
#           AND apcald = g_faaj_1.apcald_1
#           AND apcadocno = g_faaj_1.apcbdocno_1 
#     ELSE
#        #通過借方科目獲取對應的主要類型
#        SELECT DISTINCT glab002 INTO l_glab002 FROM glab_t
#         WHERE glabld = g_faaj_1.apcald_1
#           AND glab003 = '9901_01'
#           AND glab005 = g_faaj.faaj023
#        IF cl_null(l_glab002) THEN 
#           SELECT faal001 INTO l_glab002
#             FROM faal_t
#            WHERE faalent = g_enterprise
#              AND faalld = g_master.glaald
#        END IF
        SELECT faac003,faac004,faac005,faac007,faac008,faac009,faac010,faac011
          INTO g_faaj.faaj003,g_faaj.faaj004,g_faaj.faaj011,g_faah.faah033,g_faah.faah034,
               g_faah.faah035,g_faah.faah036,g_faah.faah037
          FROM faac_t
          WHERE faacent = g_enterprise
          AND faac001 = g_faah.faah006  #資產主要類型
          
        LET g_faaj.faaj005 = g_faaj.faaj004
        #根据帐套+主要类型获取折旧科目 
        SELECT glab005 INTO g_faaj.faaj023 FROM glab_t  WHERE glabent = g_enterprise AND glabld = g_faaj.faajld
           AND glab003 = '9901_01' AND glab002 = g_faah.faah006
        #根据帐套+主要类型获取折旧科目 
        SELECT glab005 INTO g_faaj.faaj025 FROM glab_t  WHERE glabent = g_enterprise AND glabld = g_faaj.faajld
           AND glab003 = '9901_03' AND glab002 = g_faah.faah006
         #根据帐套+主要类型获取累折科目 
        SELECT glab005 INTO g_faaj.faaj024 FROM glab_t WHERE glabent = g_enterprise AND glabld = g_faaj.faajld
           AND glab003 = '9901_02' AND glab002 = g_faah.faah006
         #根据帐套+主要类型获取減值準備科目 
        SELECT glab005 INTO g_faaj.faaj026 FROM glab_t WHERE glabent = g_enterprise AND glabld = g_faaj.faajld
           AND glab003 = '9901_04' AND glab002 = g_faah.faah006 
           
          SELECT faac003,faac004,faac005,faac016
            INTO g_faaj.faaj003,g_faaj.faaj004,g_faaj.faaj011,l_faac016
            FROM faac_t
           WHERE faacent = g_enterprise
             AND faac001 = g_faah.faah006  #資產主要類型
               
#     END IF
     LET g_faaj.faaj019 = l_faac016 * (g_faaj.faaj016 /100)
     #帳套是否使用本位幣二
      SELECT glaa015 INTO l_glaa015 FROM glaa_t 
       WHERE glaaent = g_enterprise
         AND glaald = g_faaj.faajld
      IF l_glaa015 = 'Y' THEN
         #本位幣二 匯率類型
         SELECT glaa016,glaa018 INTO g_faaj.faaj101,l_glaa018
           FROM glaa_t
          WHERE glaaent = g_enterprise
            AND glaald = g_faaj.faajld
            
         #本位幣二 換算基準
         SELECT glaa017 INTO l_glaa017
           FROM glaa_t
          WHERE glaaent = g_enterprise
            AND glaald = g_faaj.faajld
         
         IF l_glaa017 ='1' THEN
            #本位幣二 匯率  
            CALL s_aooi160_get_exrate('2',g_faaj.faajld,g_faaj_1.apcadocdt_1,g_faah.faah020,   #161221-00072#1 change g_today to  g_faaj_1.apcadocdt_1 lujh 
                                   #目的幣別                 #匯類類型
                                   g_faaj.faaj101,0,l_glaa018)
            RETURNING g_faaj.faaj102

            #本位幣二 成本
           LET g_faaj.faaj103 =  g_faah.faah022 *  g_faaj.faaj102
         ELSE
           #本位幣二 匯率  
           CALL s_aooi160_get_exrate('2',g_faaj.faajld,g_faaj_1.apcadocdt_1,g_faaj.faaj014,   #161221-00072#1 change g_today to  g_faaj_1.apcadocdt_1 lujh 
                                   #目的幣別                 #匯類類型
                                   g_faaj.faaj101,0,l_glaa018)
           RETURNING g_faaj.faaj102

           #本位幣二 成本
           LET g_faaj.faaj103 =  g_faah.faah024 *  g_faaj.faaj102
         END IF   
         LET g_faaj.faaj105 = g_faaj.faaj103 * l_faac016/100
         LET g_faaj.faaj104 = g_faaj.faaj017 * g_faaj.faaj102
         LET g_faaj.faaj111 = g_faaj.faaj018 * g_faaj.faaj102
         LET g_faaj.faaj108 = g_faaj.faaj028 * g_faaj.faaj102
     END IF     
      #帳套是否使用本位幣三
      SELECT glaa019 INTO l_glaa019 FROM glaa_t 
       WHERE glaaent = g_enterprise
         AND glaald = g_faaj.faajld
      IF l_glaa019 = 'Y' THEN
         #本位幣三 匯率類型
         SELECT glaa020,glaa022 INTO g_faaj.faaj151,l_glaa022
           FROM glaa_t
          WHERE glaaent = g_enterprise
            AND glaald = g_faaj.faajld
         
         #本位幣二 換算基準
         SELECT glaa021 INTO l_glaa021
           FROM glaa_t
          WHERE glaaent = g_enterprise
            AND glaald = g_faaj.faajld   
         
         IF l_glaa021 ='1' THEN
            #本位幣三 匯率  
            CALL s_aooi160_get_exrate('2',g_faaj.faajld,g_faaj_1.apcadocdt_1,g_faah.faah020,   #161221-00072#1 change g_today to  g_faaj_1.apcadocdt_1 lujh 
                                     #目的幣別                 #匯類類型
                                     g_faaj.faaj151,0,l_glaa022)
            RETURNING g_faaj.faaj152
            
            #本位幣三 成本
            LET g_faaj.faaj153 =  g_faah.faah022 *  g_faaj.faaj152  
         ELSE
            #本位幣三 匯率  
            CALL s_aooi160_get_exrate('2',g_faaj.faajld,g_faaj_1.apcadocdt_1,g_faaj.faaj014,   #161221-00072#1 change g_today to  g_faaj_1.apcadocdt_1 lujh 
                                     #目的幣別                 #匯類類型
                                     g_faaj.faaj151,0,l_glaa022)
            RETURNING g_faaj.faaj152
            
            #本位幣三 成本
            LET g_faaj.faaj153 =  g_faah.faah024 *  g_faaj.faaj152
         END IF   
         LET g_faaj.faaj155 = g_faaj.faaj153 * l_faac016/100
         LET g_faaj.faaj154 = g_faaj.faaj017 * g_faaj.faaj152
         LET g_faaj.faaj161 = g_faaj.faaj018 * g_faaj.faaj152
         LET g_faaj.faaj158 = g_faaj.faaj028 * g_faaj.faaj152
      END IF
 
#     #帳套是否使用本位幣二
#     SELECT glaa015 INTO l_glaa015 FROM glaa_t 
#      WHERE glaaent = g_enterprise
#        AND glaald = g_faaj_1.apcald_1
#     IF l_glaa015 = 'Y' THEN
#        SELECT apca120,apca121 INTO g_faaj.faaj101, g_faaj.faaj102
#          FROM apca_t
#         WHERE apcaent = g_enterprise 
#           AND apcald = g_faaj_1.apcald_1
#           AND apcadocno = g_faaj_1.apcbdocno_1
#        
#        SELECT apcb123,apcb125 INTO l_apcb123,l_apcb125
#          FROM apcb_t
#         WHERE apcbent = g_enterprise 
#          AND apcbld = g_faaj_1.apcald_1
#          AND apcbdocno = g_faaj_1.apcbdocno_1        
#        IF g_flag = 'Y' THEN LET g_faaj.faaj103 = l_apcb125 END IF  #含稅成本
#        IF g_flag = 'N' THEN LET g_faaj.faaj103 = l_apcb123 END IF  #未稅成本
#                
#           
#     END IF     
#      #帳套是否使用本位幣三
#     SELECT glaa019 INTO l_glaa019 FROM glaa_t 
#      WHERE glaaent = g_enterprise
#        AND glaald = g_faaj_1.apcald_1
#     IF l_glaa015 = 'Y' THEN
#        SELECT apca120,apca121 INTO g_faaj.faaj151, g_faaj.faaj152
#          FROM apca_t
#         WHERE apcaent = g_enterprise 
#           AND apcald = g_faaj_1.apcald_1
#           AND apcadocno = g_faaj_1.apcbdocno_1     
#
#        SELECT apcb133,apcb135 INTO l_apcb133,l_apcb135
#          FROM apcb_t
#         WHERE apcbent = g_enterprise 
#          AND apcbld = g_faaj_1.apcald_1
#          AND apcbdocno = g_faaj_1.apcbdocno_1       
#        IF g_flag = 'Y' THEN LET g_faaj.faaj153 = l_apcb135 END IF  #含稅成本
#        IF g_flag = 'N' THEN LET g_faaj.faaj153 = l_apcb133 END IF  #未稅成本
#     END IF     
     
     
#     CALL s_transaction_begin()
     #INSERT INTO faaj_t VALUES(g_faaj.*) #mark by geza 20161121 #161111-00028#6 
     #add by geza 20161121 #161111-00028#6(S)
     INSERT INTO faaj_t (faajent,  faajld,   faajsite, faaj000,  faaj001,
                         faaj002,  faaj003,  faaj004,  faaj005,  faaj006,
                         faaj007,  faaj008,  faaj009,  faaj010,  faaj011,
                         faaj012,  faaj013,  faaj014,  faaj015,  faaj016,
                         faaj017,  faaj018,  faaj019,  faaj020,  faaj021,
                         faaj022,  faaj023,  faaj024,  faaj025,  faaj026,
                         faaj027,  faaj028,  faaj029,  faaj030,  faaj031,
                         faaj032,  faaj033,  faaj034,  faaj035,  faaj036,
                         faaj037,  faaj038,  faaj039,  faaj040,  faaj041,
                         faaj042,  faaj043,  faaj044,  faaj045,  faaj046,
                         faaj047,  faaj101,  faaj102,  faaj103,  faaj104,
                         faaj105,  faaj106,  faaj107,  faaj108,  faaj109,
                         faaj110,  faaj111,  faaj112,  faaj113,  faaj114,
                         faaj115,  faaj116,  faaj117,  faaj151,  faaj152,
                         faaj153,  faaj154,  faaj155,  faaj156,  faaj157,
                         faaj158,  faaj159,  faaj160,  faaj161,  faaj162,
                         faaj163,  faaj164,  faaj165,  faaj166,  faaj167,
                         faajownid,faajowndp,faajcrtid,faajcrtdp,faajcrtdt,
                         faajmodid,faajmoddt,faajstus, faaj048)
                  VALUES(g_faaj.faajent,  g_faaj.faajld,   g_faaj.faajsite, g_faaj.faaj000,  g_faaj.faaj001,
                         g_faaj.faaj002,  g_faaj.faaj003,  g_faaj.faaj004,  g_faaj.faaj005,  g_faaj.faaj006,
                         g_faaj.faaj007,  g_faaj.faaj008,  g_faaj.faaj009,  g_faaj.faaj010,  g_faaj.faaj011,
                         g_faaj.faaj012,  g_faaj.faaj013,  g_faaj.faaj014,  g_faaj.faaj015,  g_faaj.faaj016,
                         g_faaj.faaj017,  g_faaj.faaj018,  g_faaj.faaj019,  g_faaj.faaj020,  g_faaj.faaj021,
                         g_faaj.faaj022,  g_faaj.faaj023,  g_faaj.faaj024,  g_faaj.faaj025,  g_faaj.faaj026,
                         g_faaj.faaj027,  g_faaj.faaj028,  g_faaj.faaj029,  g_faaj.faaj030,  g_faaj.faaj031,
                         g_faaj.faaj032,  g_faaj.faaj033,  g_faaj.faaj034,  g_faaj.faaj035,  g_faaj.faaj036,
                         g_faaj.faaj037,  g_faaj.faaj038,  g_faaj.faaj039,  g_faaj.faaj040,  g_faaj.faaj041,
                         g_faaj.faaj042,  g_faaj.faaj043,  g_faaj.faaj044,  g_faaj.faaj045,  g_faaj.faaj046,
                         g_faaj.faaj047,  g_faaj.faaj101,  g_faaj.faaj102,  g_faaj.faaj103,  g_faaj.faaj104,
                         g_faaj.faaj105,  g_faaj.faaj106,  g_faaj.faaj107,  g_faaj.faaj108,  g_faaj.faaj109,
                         g_faaj.faaj110,  g_faaj.faaj111,  g_faaj.faaj112,  g_faaj.faaj113,  g_faaj.faaj114,
                         g_faaj.faaj115,  g_faaj.faaj116,  g_faaj.faaj117,  g_faaj.faaj151,  g_faaj.faaj152,
                         g_faaj.faaj153,  g_faaj.faaj154,  g_faaj.faaj155,  g_faaj.faaj156,  g_faaj.faaj157,
                         g_faaj.faaj158,  g_faaj.faaj159,  g_faaj.faaj160,  g_faaj.faaj161,  g_faaj.faaj162,
                         g_faaj.faaj163,  g_faaj.faaj164,  g_faaj.faaj165,  g_faaj.faaj166,  g_faaj.faaj167,
                         g_faaj.faajownid,g_faaj.faajowndp,g_faaj.faajcrtid,g_faaj.faajcrtdp,g_faaj.faajcrtdt,
                         g_faaj.faajmodid,g_faaj.faajmoddt,g_faaj.faajstus, g_faaj.faaj048) 
     #add by geza 20161121 #161111-00028#6(E)                          
     IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "g_faaj"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         CALL s_transaction_end('N','0')
         LET g_success = FALSE
         RETURN g_success
      END IF
      
   END FOREACH
#  CALL s_transaction_end('Y','0')
END FUNCTION

################################################################################
# Descriptions...: 卡片編號
# Memo...........:
# Usage..........: CALL afap200_get_faah001()
# Input parameter:  
# Date & Author..: 2014/12/5 By 02003
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_get_faah001()
   DEFINE l_ooab002     LIKE ooab_t.ooab002
   DEFINE l_max_faah001 LIKE faah_t.faah001
   DEFINE l_faah001     LIKE faah_t.faah001

    #檢查tmp中是否存在已有最大的卡片編號
    #是否自動編號 S-FIN-9005
    SELECT ooab002 INTO l_ooab002 FROM ooab_t
     WHERE ooabent = g_enterprise
       AND ooab001 = 'S-FIN-9005'
       AND ooabsite = g_site

    SELECT MAX(faah001) INTO l_max_faah001 FROM afap200_tmp02    # 160727-00019#1 Mod  afap200_apcb_tmp--> afap200_tmp02

    IF l_max_faah001 IS NULL  THEN
       IF l_ooab002 = 'Y' THEN
          SELECT MAX(faah001) INTO l_max_faah001 FROM faah_t WHERE faahent=g_enterprise #160905-00007#1 add
          LET l_faah001 = l_max_faah001+1 USING '&&&&&&&&&&'
       ELSE
          LET l_faah001 = ''
       END IF
    ELSE
       IF l_ooab002 = 'Y' THEN
          LET l_faah001 = l_max_faah001+1 USING '&&&&&&&&&&'
       ELSE
          LET l_faah001 = ''
       END IF
    END IF
    RETURN l_faah001
END FUNCTION

################################################################################
# Descriptions...: 财产编号检查
# Memo...........:
# Usage..........: CALL afap200_faah003_chk()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/12/08 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_faah003_chk()
   DEFINE l_n      LIKE type_t.num5

   IF NOT cl_null(g_apcb_d[l_ac].faah002) 
   AND NOT cl_null(g_apcb_d[l_ac].faah003)
   AND g_apcb_d[l_ac].faah002 <> '1' THEN
      SELECT count(*) INTO l_n
        FROM faah_t
       WHERE faahent = g_enterprise
         AND faah003 = g_apcb_d[l_ac].faah003
         AND faah002 = '1'

      IF l_n = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-00016'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF

#   IF NOT cl_null(g_apcb_d[l_ac].faah003) AND g_apcb_d[l_ac].faah002 = '1' THEN
#      SELECT count(*) INTO l_n
#        FROM faah_t
#       WHERE faahent = g_enterprise
#         AND faah003 = g_apcb_d[l_ac].faah003
#         AND faah002 = '1'
#
#      IF l_n > 0 THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'afa-00252'
#         LET g_errparam.extend = ''
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#
#         RETURN FALSE
#      END IF
#   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 执行操作
# Memo...........:
# Usage..........: CALL afap200_process_1(ls_js)
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/12/08 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_process_1(ls_js)
   DEFINE ls_js       STRING
   DEFINE lc_param    type_parameter
   DEFINE li_stus     LIKE type_t.num5
   DEFINE li_count    LIKE type_t.num10  #progressbar計量
   DEFINE l_sql       STRING             #主SQL
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_flag      LIKE type_t.chr1
   DEFINE l_check     LIKE type_t.chr1
   DEFINE g_apcbdocno_t LIKE apcb_t.apcbdocno
   DEFINE l_apcb002 LIKE apcb_t.apcb002
   DEFINE l_apcb003 LIKE apcb_t.apcb003
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE li_idx    LIKE type_t.num5
   DEFINE l_n       LIKE type_t.num5
   DEFINE l_apcb    type_g_apcb_d 
   
   CALL util.JSON.parse(ls_js,lc_param)

   IF g_bgjob = "N" THEN   
      #錯誤訊息彙總初始
      #CALL cl_showmsg_init()       #150731-00004#1 20150807 mark
      CALL cl_err_collect_init()   #150731-00004#1 20150807 add
      LET l_flag = 'Y'   #標記是否已產生資料
      LET g_flag_1 = 'Y' #標記是否可以產生成功 
      LET g_apcbdocno = ''
      LET g_apcbdocno_t = ' '
      LET l_n = 0
      SELECT COUNT(*) INTO l_n 
        FROM afap200_tmp02    # 160727-00019#1 Mod  afap200_apcb_tmp--> afap200_tmp02
       WHERE b = 'Y'
       
      IF l_n = 0 THEN   #表示都未勾選
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-00041'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_flag_1 = 'N'               
      ELSE
         IF cl_ask_promp('afa-00035') THEN
            LET g_flag = 'N'                 #未稅
         ELSE
            LET g_flag = 'Y'                 #含稅
         END IF
      END IF    
      LET l_sql = "SELECT * FROM afap200_tmp02 WHERE b = 'Y' "    # 160727-00019#1 Mod  afap200_apcb_tmp--> afap200_tmp02
     #DECLARE afap200_process_cs CURSOR FROM l_sql  #151013-00019#3
      #151013-00019#3 add ------
      PREPARE afap200_process_pr FROM l_sql
      DECLARE afap200_process_cs CURSOR WITH HOLD FOR afap200_process_pr
      #151013-00019#3 add end---
      FOREACH afap200_process_cs INTO l_apcb.*
         #151013-00019#3 add ------
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach afap200_process_cs'
            LET g_errparam.popup = FALSE
            CALL cl_err()
            EXIT FOREACH
         END IF
         #151013-00019#3 add end---
         IF g_master.a = 'Y' THEN    #在建工程產生faak_t底稿；非在建工程產生faah_t底稿
            #已產生底稿的應付帳款不能再次拋轉
            IF l_apcb.apcbdocno <> g_apcbdocno_t THEN 
               IF g_master.f ='1' THEN #160426-00014#15 add
                  SELECT COUNT(*) INTO l_cnt FROM faak_t
                   WHERE faakent = g_enterprise
                     AND faakld = g_master.glaald
                     AND faak041 = l_apcb.apcbdocno 
                     AND faak044 = l_apcb.apcbseq
               #160426-00014#15 add s---      
               ELSE
                  SELECT COUNT(*) INTO l_cnt FROM faak_t
                   WHERE faakent = g_enterprise
                     AND faakld = g_master.glaald
                     AND faak047 = l_apcb.apcbdocno 
                     AND faak045 = l_apcb.apcbseq               
               END IF               
               #160426-00014#15 add e---
               IF l_cnt > 0 THEN
                  #150731-00004#1 20150807 str---
                  #CALL cl_errmsg('',l_apcb.apcbdocno,'','afa-00038',1)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00038'
                  LET g_errparam.extend = l_apcb.apcbdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #150731-00004#1 20150807 end---
                  LET l_flag = 'N'  
                  LET g_flag_1 = 'N'                        
               END IF 
            END IF
            LET g_apcbdocno_t = l_apcb.apcbdocno
            CALL s_transaction_begin()                     
            IF l_flag = 'Y' THEN   
               LET g_success = TRUE  
               #chenying mod--str-- 
               #20141123 项目编号+WBS为必输项，当apcb抓不到值自行输入后ins到faak中
               #需传入项目编号+WBS的值
               CALL afap200_ins_faak(l_apcb.*)                   
               RETURNING g_success   
               IF g_success = FALSE THEN
                  LET g_flag_1 = 'N'
               ELSE
                  IF cl_null(g_apcbdocno) THEN 
                     #LET g_apcbdocno="'",l_apcb.apcbdocno,"' AND faak044=",l_apcb.apcbseq,")"  #160426-00014#15 mark
                     LET g_apcbdocno="'",l_apcb.apcbdocno,"' AND (faak044=",l_apcb.apcbseq," OR faak045=",l_apcb.apcbseq,"))"   #160426-00014#15 add
                  ELSE
                     #LET g_apcbdocno=g_apcbdocno," OR ( faak041='",l_apcb.apcbdocno,"' AND faak044 =",l_apcb.apcbseq,")" #160426-00014#15 mark
                     LET g_apcbdocno=g_apcbdocno," OR ( faak041='",l_apcb.apcbdocno,"' AND faak044 =",l_apcb.apcbseq,") OR ( faak047='",l_apcb.apcbdocno,"' AND faak045 =",l_apcb.apcbseq,") "  #160426-00014#15 add
                  END IF
               END IF
            END IF   
         ELSE
            #已產生卡片的應付帳款不能再次拋轉
             IF l_apcb.apcbdocno <> g_apcbdocno_t THEN 
                SELECT COUNT(*) INTO l_cnt FROM faah_t
                 WHERE faahent = g_enterprise
                  AND faah040 = l_apcb.apcbdocno 
                  AND faah045 = l_apcb.apcbseq
               IF l_cnt > 0 THEN
                  #150731-00004#1 20150807 str---
                  #CALL cl_errmsg('',l_apcb.apcbdocno,'','afa-00038',1)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00038'
                  LET g_errparam.extend = l_apcb.apcbdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #150731-00004#1 20150807 end---
                  LET l_flag = 'N'  
                  LET g_flag_1 = 'N'                        
               END IF 
            END IF
            LET g_apcbdocno_t =l_apcb.apcbdocno
            CALL s_transaction_begin()     #150925            
            IF l_flag = 'Y' THEN
               LET g_success = TRUE                     
               CALL afap200_ins_faah(l_apcb.*)
                 RETURNING g_success
               IF g_success = FALSE THEN  #多筆數據中有返回FALSE就先標記
                  LET g_flag_1 = 'N'
               ELSE 
                  IF cl_null(g_apcbdocno) THEN 
                     #LET g_apcbdocno="'",l_apcb.apcbdocno,"' AND faah045=",l_apcb.apcbseq,")" #160426-00014#15 mark
                     LET g_apcbdocno="'",l_apcb.apcbdocno,"' AND (faah045=",l_apcb.apcbseq," OR faah058=",l_apcb.apcbseq," ))"  #160426-00014#15 add
                  ELSE
                     #LET g_apcbdocno=g_apcbdocno," OR (faah040='",l_apcb.apcbdocno,"' AND faah045=",l_apcb.apcbseq,")" #160426-00014#15 mark
                     LET g_apcbdocno=g_apcbdocno," OR (faah040='",l_apcb.apcbdocno,"' AND faah045=",l_apcb.apcbseq,") OR (faah057='",l_apcb.apcbdocno,"' AND faah058=",l_apcb.apcbseq,") "  #160426-00014#15 add
                  END IF
               END IF  
            END IF  
         END IF             
      END FOREACH 
     #CALL cl_err_showmsg()       #150731-00004#1 20150807 mark
      CALL cl_err_collect_show()  #150731-00004#1 20150807 add
      IF g_flag_1 = 'N' THEN    #有返回False的標記就提示失敗，插入失敗
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'adz-00218'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err() 
         LET g_success = FALSE
      ELSE
         CALL s_transaction_end('Y','0')  
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'adz-00217'
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()    
         IF g_master.a = 'Y' THEN
            LET la_param.prog = 'afai120'
            IF g_master.f = '1' THEN  #160426-00014#15
               LET la_param.param[7] = g_apcbdocno
            #160426-00014#15 add s---   
            ELSE
               LET la_param.param[8] = g_apcbdocno
            END IF
            #160426-00014#15 add e---                 
            LET ls_js = util.JSON.stringify(la_param)
            CALL cl_cmdrun(ls_js)
         ELSE
            LET la_param.prog = 'afai100'
            IF g_master.f = '1' THEN  #160426-00014#15
               LET la_param.param[5] = g_apcbdocno
            #160426-00014#15 add s---   
            ELSE
               LET la_param.param[7] = g_apcbdocno
            END IF
            #160426-00014#15 add e---            
            LET ls_js = util.JSON.stringify(la_param)
            CALL cl_cmdrun(ls_js)
         END IF
      END IF      
      LET INT_FLAG = TRUE
      CALL cl_ask_confirm3("std-00012","")
   ELSE
   END IF
END FUNCTION

################################################################################
# Descriptions...: 固定資產基礎資料
# Memo...........:
# Usage..........: CALL afap200_ins_faah(l_apca)
#                   
# Input parameter:  
#                :  
# Return code....:  
#                :  
# Date & Author..: 2014/2/27 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_ins_faah(l_apca)
DEFINE l_apca    type_g_apcb_d 
DEFINE l_max_faah001 LIKE faah_t.faah000
DEFINE l_ooab002 LIKE ooab_t.ooab002
DEFINE l_ooab002_1 LIKE ooab_t.ooab002
DEFINE p_b LIKE type_t.chr1
DEFINE p_c LIKE type_t.chr1
DEFINE l_max1            LIKE type_t.chr10
DEFINE l_ym              LIKE type_t.chr10
DEFINE l_yy              LIKE type_t.num5
DEFINE l_mm              LIKE type_t.num5
DEFINE l_cy              LIKE type_t.chr4
DEFINE l_cm              LIKE type_t.chr2
DEFINE l_t1              LIKE type_t.chr80
DEFINE l_glaa015         LIKE glaa_t.glaa015
DEFINE l_glaa019         LIKE glaa_t.glaa019
DEFINE l_apcb123         LIKE apcb_t.apcb123
DEFINE l_apcb125         LIKE apcb_t.apcb125
DEFINE l_apcb133         LIKE apcb_t.apcb133
DEFINE l_apcb135         LIKE apcb_t.apcb135
DEFINE l_glab002         LIKE glab_t.glab002
DEFINE l_apcb002         LIKE apcb_t.apcb002
DEFINE l_apcb003         LIKE apcb_t.apcb003
DEFINE p_faah003         LIKE faah_t.faah003
DEFINE l_glaa022         LIKE glaa_t.glaa022 
DEFINE l_glaa018         LIKE glaa_t.glaa018
DEFINE l_glaa025         LIKE glaa_t.glaa025
DEFINE l_glaa021         LIKE glaa_t.glaa021
DEFINE l_glaa017         LIKE glaa_t.glaa017
DEFINE l_year            LIKE type_t.num5
DEFINE l_month           LIKE type_t.num5
DEFINE l_num1            LIKE type_t.num5
DEFINE l_num2            LIKE type_t.num5
DEFINE l_str             STRING
DEFINE l_str1            STRING
DEFINE l_str2            STRING
DEFINE l_faac016         LIKE faac_t.faac016
DEFINE l_sql             STRING
DEFINE l_success         LIKE type_t.num5
DEFINE l_fristdate       LIKE faah_t.faah014     #161223-00055#1 add lujh
DEFINE l_glaa001         LIKE glaa_t.glaa001 #160426-00014#15

   WHENEVER ERROR CONTINUE
   LET g_success = TRUE

   #160426-00014#15 add s---
   SELECT glaa001,glaa025 INTO l_glaa001,l_glaa025
    FROM glaa_t  
   WHERE glaaent = g_enterprise
     AND glaald = g_master.glaald 
   #160426-00014#15 add e---  
   
   INITIALIZE g_faah.* TO NULL
   LET g_faah.faahent = g_enterprise
   LET g_faah.faah000 = l_apca.t #產生批號
   
  ###################################mark by huangtao
  #IF g_para_data = 'Y' THEN
  #   IF cl_null(g_faah.faah001) THEN 
  #      SELECT MAX(faah001) INTO l_max_faah001 FROM faah_t
  #   ELSE
  #      LET l_max_faah001 = g_faah.faah001    
  #   END IF    
  #   IF l_max_faah001 IS NULL THEN LET l_max_faah001 =0 END IF
  #   LET g_faah.faah001 =l_max_faah001+1 USING '&&&&&&&&&&' 
  #ELSE
  #   LET g_faah.faah001 = l_apca.faah001
  #END IF
   IF g_para_data = 'Y' THEN
     LET l_sql =  " SELECT lpad((MAX(CAST(faah001 AS NUMBER(10,0))) + 1),10,'0') FROM faah_t ",
                  "  WHERE faahent ='",g_enterprise,"'",
                  "    AND regexp_substr(faah001,'[0-9]+') IS NOT NULL",
                  "    AND faah032 = '",g_master.ooef001,"'"     #161009-00006#4 add lujh                          
     PREPARE sel_faah001 FROM l_sql
     EXECUTE sel_faah001 INTO g_faah.faah001
     IF cl_null(g_faah.faah001) THEN 
         LET g_faah.faah001 = '0000000001'
     END IF
   ELSE
      LET g_faah.faah001 = l_apca.faah001
   END IF
   ###################################mark by huangtao

   #LET g_faah.faah002 = 1         #型態  mark by huangtao
    LET g_faah.faah002= l_apca.faah002
   
   #卡片編號與財產編號是否一致，不一致則為空
   #財產編號
#   SELECT ooab002 INTO l_ooab002_1 FROM ooab_t
#    WHERE ooabent = g_enterprise
#      AND ooab001 = 'S-FIN-9002'
#      AND ooabsite = g_site 
#   IF l_ooab002_1 = 'Y' THEN   
#      LET g_faah.faah003 = g_faah.faah001    
#   ELSE
      LET g_faah.faah003 = l_apca.faah003
#   END IF 
       
   LET g_faah.faah004 = l_apca.faah004   #附號
   LET g_faah.faah005 = 1                #資產性質
   LET g_faah.faah006 = l_apca.faah006   #資產主要類型 
   LET g_faah.faah007 = l_apca.faah007   #資產次要類型  
   LET g_faah.faah008 = ''        #資產組
#   LET g_faah.faah014 = g_today           #取得日期 #20150210 mark
   LET g_faah.faah014 = l_apca.apcadocdt   #取得日期  #20150210 add 单据日期 
   LET g_faah.faah015 = 0         #資產狀態
   LET g_faah.faah009 = l_apca.apca004 #供應商
   LET g_faah.faah010 = l_apca.apca004 #製造商
   LET g_faah.faah019 = 0         #在外數量
   LET g_faah.faah027 = l_apca.faah027
   IF g_master.f = '1' THEN  #160426-00014#15 add
      #規格名稱（產生編號）、單位、數量
      SELECT apcb004,apcb005,apcb006,apcb007
        #INTO g_faah.faah012,g_faah.faah013,g_faah.faah017,g_faah.faah018  #151105-00001#3 mark
        INTO g_faah.faah013,g_faah.faah012,g_faah.faah017,g_faah.faah018   #151105-00001#3
        FROM apcb_t
       WHERE apcbent = g_enterprise 
         AND apcbld = g_master.glaald
         AND apcbdocno = l_apca.apcbdocno 
         AND apcbseq = l_apca.apcbseq
         
      #所有組織 
      SELECT apcasite INTO g_faah.faah041 FROM apca_t
       WHERE apcaent = g_enterprise 
         AND apcald = g_master.glaald 
         AND apcadocno = l_apca.apcbdocno         
   #160426-00014#15 add s---      
   ELSE
      SELECT imaal003,imaal004 INTO g_faah.faah012,g_faah.faah013 FROM imaal_t WHERE imaalent = g_enterprise AND imaal001 = l_apca.apcb004 AND imaal002 = g_dlang
      SELECT oocal003 INTO g_faah.faah017 FROM oocal_t WHERE oocalent = g_enterprise AND oocal001 = l_apca.inbb010 AND oocal002 = g_dlang
      #規格名稱（產生編號）、單位、數量
      SELECT inbb011 INTO g_faah.faah018   
        FROM inbb_t
       WHERE inbbent = g_enterprise 
         AND inbbdocno = l_apca.apcbdocno 
         AND inbbseq = l_apca.apcbseq   

      #所有組織 
      SELECT inbasite INTO g_faah.faah041 FROM inba_t
       WHERE inbaent = g_enterprise 
         AND inbadocno = l_apca.apcbdocno 
   END IF   
   #160426-00014#15 add e---
   

   IF g_master.f ='1' THEN #160426-00014#15 add
      
         IF g_flag = 'Y' THEN #含税
              #原幣單價、本幣單價、原幣含税金額、本幣含税金額
      #20150211 mod str        
      #      SELECT apcb101,apcb105,apcb111,apcb115 
      #       INTO g_faah.faah021,g_faah.faah022,g_faah.faah023,g_faah.faah024 
            SELECT apcb105,apcb115 
             INTO g_faah.faah022,g_faah.faah024 
      #20150211 mod end 
             FROM apcb_t
            WHERE apcbent = g_enterprise 
              AND apcbld = g_master.glaald
              AND apcbdocno = l_apca.apcbdocno 
              AND apcbseq = l_apca.apcbseq 
         ELSE   
          #原幣單價、本幣單價、原幣未税金額、本幣未税金額
      #20150211 mod str      
      #    SELECT apcb101,apcb103,apcb111,apcb113 
      #     INTO g_faah.faah021,g_faah.faah022,g_faah.faah023,g_faah.faah024 
          SELECT apcb103,apcb113 
           INTO g_faah.faah022,g_faah.faah024
      #20150211 mod end  
           FROM apcb_t
          WHERE apcbent = g_enterprise 
            AND apcbld = g_master.glaald
            AND apcbdocno = l_apca.apcbdocno 
            AND apcbseq = l_apca.apcbseq 
         END IF   
   #160426-00014#15 add s---      
   ELSE
      LET g_faah.faah022 = l_apca.xccc280_inbb011
      LET g_faah.faah024 = l_apca.xccc280_inbb011
   END IF
   #160426-00014#15 add e---
   #20150211 add str
   LET g_faah.faah021 = g_faah.faah022 / g_faah.faah018
   LET g_faah.faah023 = g_faah.faah024 / g_faah.faah018
   #20150211 add end
   
   #####################add by huangtao
   IF g_master.f = '1' THEN  #160426-00014#15 add
      SELECT apcb002,apcb003 INTO l_apcb002,l_apcb003 FROM apcb_t
       WHERE apcbent = g_enterprise 
         AND apcbld = g_master.glaald
         AND apcbdocno = l_apca.apcbdocno 
         AND apcbseq = l_apca.apcbseq 
         
      LET g_faah.faah039 = l_apcb002
   #160426-00014#15 add s---   
   ELSE         
      LET g_faah.faah039 = ''   
   END IF   
   #160426-00014#15 add e---
   IF NOT cl_null(l_apcb002) AND NOT cl_null(l_apcb003) THEN
     SELECT pmdt001 INTO g_faah.faah038 FROM pmdt_t
      WHERE pmdtent = g_enterprise AND pmdtdocno = l_apcb002 AND pmdtseq = l_apcb003 
   END IF
   #####################add by huangtao
   IF g_master.f = '1' THEN #160426-00014#15 add
      LET g_faah.faah020 = l_apca.apca100 #幣別
   #160426-00014#15 add s---   
   ELSE
      LET g_faah.faah020 = l_glaa001      
   END IF   
   #160426-00014#15 add e---
   IF g_master.f = '1' THEN  #160426-00014#1 add
      LET g_faah.faah040 = l_apca.apcbdocno #帳款編號 
      LET g_faah.faah045 = l_apca.apcbseq #帳款編號項次
   #160426-00014#1 add s---   
   ELSE
      LET g_faah.faah057 = l_apca.apcbdocno #雜發單號 
      LET g_faah.faah058 = l_apca.apcbseq   #雜發單號項次     
   END IF   
   #160426-00014#1 add e---
   LET g_faah.faah042 = 1         #資產屬性
   LET g_faah.faah016 = 1         #取得方式
   LET g_faah.faah011 = ''        #產地
   IF NOT cl_null(l_apcb002) THEN 
      #取入库单人员，部门
      SELECT pmds002,pmds003 INTO g_faah.faah025,g_faah.faah026
        FROM pmds_t
       WHERE pmdsent = g_enterprise
         AND pmdsdocno = l_apcb002
   ELSE
      #取賬款單人员、部门
      SELECT apca003 INTO g_faah.faah025
        FROM apca_t
       WHERE apcaent = g_enterprise
         AND apcadocno = l_apca.apcbdocno 
      #人员对应的部门
      SELECT ooag003 INTO g_faah.faah026
        FROM ooag_t
       WHERE ooagent = g_enterprise
         AND ooag001 = g_faah.faah025
   END IF
   LET g_faah.faah028= g_master.ooef001
   LET g_faah.faah029= g_user
   LET g_faah.faah030= g_master.ooef001
   LET g_faah.faah031= g_master.ooef001
   LET g_faah.faah032= g_master.ooef001
#   LET g_faah.faah033= 'N'     #1211
   
   LET g_faah.faahownid = g_user  #資料所有者
   LET g_faah.faahowndp = g_dept  #資料所屬部門
   LET g_faah.faahcrtid = g_user  #資料建立者
   LET g_faah.faahcrtdp = g_dept  #資料建立部門
   LET g_faah.faahcrtdt = g_today #資料創建日
   LET g_faah.faahstus = 'N'      #狀態碼
   
   #主帳套faah_t新增成功后，继续新增faaj_t   
   
      INITIALIZE g_faaj.* TO NULL
      LET g_faaj.faajent = g_enterprise  
      LET g_faaj.faajld = g_master.glaald
      LET g_faaj.faaj001 = g_faah.faah003 #財產編號
      #######################################mod by huangtao
      IF g_faah.faah002 = '1' THEN
         LET g_faaj.faaj002 = ' ' #附號
      ELSE
         LET g_faaj.faaj002 = l_apca.faah004
      END IF
      #######################################mod by huangtao
      LET g_faaj.faajsite = g_site
      LET g_faaj.faaj006 = '1'
      SELECT apcb010 INTO g_faaj.faaj007
        FROM apcb_t
       WHERE apcbent = g_enterprise
         AND apcbdocno = l_apca.apcbdocno
         AND apcbseq = l_apca.apcbseq
      IF cl_null(g_faaj.faaj007) THEN 
         SELECT apca015 INTO g_faaj.faaj007
           FROM apca_t
          WHERE apcaent = g_enterprise
            AND apcadocno = l_apca.apcbdocno
         IF cl_null(g_faaj.faaj007) THEN 
            SELECT ooag003 INTO g_faaj.faaj007
              FROM ooag_t 
             WHERE ooagent = g_enterprise
               AND ooag001 = g_user
         END IF 
      END IF 
      IF g_master.f = 1 THEN            #160426-00014#15 add
         LET g_faaj.faaj030 = l_apca.apcbdocno  #應付單據
      END IF   #160426-00014#15 add  
      LET g_faaj.faaj031 = l_apca.apcbseq    #帳款編號項次
      LET g_faaj.faaj022 =0 
      LET g_faaj.faaj017=0
      LET g_faaj.faaj018=0
      LET g_faaj.faaj033=0
      LET g_faaj.faaj034=0
      LET g_faaj.faaj035=0
      LET g_faaj.faaj032=0
      LET g_faaj.faaj027=0
      LET g_faaj.faaj021=0
      LET g_faaj.faaj117 = 0
      LET g_faaj.faaj113 = 0
      LET g_faaj.faaj114 = 0
      LET g_faaj.faaj115 = 0
      LET g_faaj.faaj110 = 0
      LET g_faaj.faaj112 = 0
      LET g_faaj.faaj167 = 0
      LET g_faaj.faaj163 = 0
      LET g_faaj.faaj164 = 0
      LET g_faaj.faaj165 = 0
      LET g_faaj.faaj160 = 0
      LET g_faaj.faaj162 = 0
      LET g_faaj.faaj042=l_apca.apca004 #交易客商
      LET g_faaj.faaj043=l_apca.apca004 #账款客商
      #批號= faah000
      LET g_faaj.faaj000 = g_faah.faah000
      LET g_faaj.faaj037 = g_faah.faah001   #卡片編號  
      #LET g_faaj.faaj038 = ''               #資產狀態    ##160426-00014#15 mark
      LET g_faaj.faaj038 = 0 #160426-00014#15 add       
#      LET g_faaj.faaj005 = 0 #未使用年限
#      LET g_faaj.faaj009 = 0 #最近折舊年度
#      LET g_faaj.faaj010 = 0 #最近折舊期別
      LET g_faaj.faaj017 = 0 #累折
#      LET g_faaj.faaj019 = 0 #預留殘值
      LET g_faaj.faaj020 = 0 #調整成本
      #add by yangxf ---
      #抓取本月入帳提列方式
      SELECT faal005,faal006 INTO g_faal005,g_faaj.faaj048  #161129-00048#1 add faaj048列帳/列管 
        FROM faal_t
       WHERE faalent = g_enterprise
         AND faalld  = g_faaj.faajld
         AND faal001 = g_faah.faah006
      
      LET l_year = YEAR(g_faah.faah014)
      LET l_month = MONTH(g_faah.faah014)
      #161223-00055#1--mark--str--lujh
      #IF g_faal005 = '1' THEN
      #   LET l_num2 = l_month + 1
      #   IF l_num2 > 12 THEN
      #      LET l_num2 = 1
      #      LET l_num1 = l_year + 1
      #   ELSE
      #      LET l_num2 = l_num2
      #      LET l_num1 = l_year
      #   END IF
      #ELSE
      #   LET l_num1 = l_year
      #   LET l_num2 = l_month
      #END IF
      #161223-00055#1--mark--end--lujh
      
      #161223-00055#1--add--str--lujh
      IF g_faal005 = '1' THEN 
         LET l_num2 = l_month + 1
         IF l_num2 > 12 THEN 
            LET l_num2 = 1
            LET l_num1 = l_year + 1
         ELSE
            LET l_num2 = l_num2
            LET l_num1 = l_year
         END IF
      END IF 
      IF g_faal005 = '2' OR g_faal005 = '4' THEN 
         LET l_num1 = l_year
         LET l_num2 = l_month
      END IF
      IF g_faal005 = '3' THEN
         CALL s_date_get_first_date(g_faah.faah014) RETURNING l_fristdate
         LET l_fristdate = l_fristdate + 14
         IF g_faah.faah014 <= l_fristdate THEN 
            LET l_num1 = l_year
            LET l_num2 = l_month
         ELSE
            LET l_num2 = l_month + 1
            IF l_num2 > 12 THEN 
               LET l_num2 = 1
               LET l_num1 = l_year + 1
            ELSE
               LET l_num2 = l_num2
               LET l_num1 = l_year
            END IF
         END IF 
      END IF 
      #161223-00055#1--add--end--lujh
      
      LET l_str1 = l_num1
      LET l_str2 = l_num2
      IF l_num2 < 10 THEN
         LET l_str = l_str1 CLIPPED,'0' CLIPPED,l_str2 CLIPPED
      ELSE
         LET l_str = l_str1 CLIPPED,l_str2 CLIPPED
      END IF
      LET g_faaj.faaj008 = l_str.trim()
      #add by yangxf ---
#      LET g_faaj.faaj008 = ''
      LET g_faaj.faaj045 = l_apca.apcb015
      LET g_faaj.faaj046 = l_apca.apcb016
      LET g_faaj.faajownid = g_user  #資料所有者
      LET g_faaj.faajowndp = g_dept #資料所屬部門
      LET g_faaj.faajcrtid = g_user  #資料建立者
      LET g_faaj.faajcrtdp = g_dept #資料建立部門
      LET g_faaj.faajcrtdt = g_today #資料創建日
      LET g_faaj.faajstus = 'N'      #狀態碼
      #本位币、匯率類型
      SELECT glaa001,glaa025 INTO g_faaj.faaj014,l_glaa025
       FROM glaa_t  
      WHERE glaaent = g_enterprise
        AND glaald = g_faaj.faajld 
      
      IF g_master.f = '1' THEN  #160426-00014#15 add     
         #原單據匯率
         SELECT apca101 INTO g_faaj.faaj015 FROM apca_t WHERE apcaent=g_enterprise 
                                       AND apcald=g_faaj.faajld AND apcadocno=l_apca.apcbdocno
      #160426-00014#15 add s---                                 
      ELSE
               #本位幣 匯率  
         CALL s_aooi160_get_exrate('2',g_faaj.faajld,g_today,g_faaj.faaj014,   #161221-00072#1 change g_today to  g_faaj_1.apcadocdt_1 lujh 
                                   #目的幣別                 #匯類類型
                                   g_faaj.faaj014,0,l_glaa025)
         RETURNING g_faaj.faaj015  
      END IF      
      #160426-00014#15 add e---
      #成本  （已考慮含稅否,faah原幣金額*匯率）
      LET g_faaj.faaj016 = g_faah.faah022 * g_faaj.faaj015
      LET g_faaj.faaj028 = g_faaj.faaj016   #未折減額
      SELECT faac003,faac004,faac005,faac016,faac008,faac009,faac010,faac011,faac007
        INTO g_faaj.faaj003,g_faaj.faaj004,g_faaj.faaj011,l_faac016,
             g_faah.faah034,g_faah.faah035,g_faah.faah036,g_faah.faah037,g_faah.faah033
        FROM faac_t
       WHERE faacent = g_enterprise
         AND faac001 = g_faah.faah006  #資產主要類型
      LET g_faaj.faaj005 = g_faaj.faaj004
      LET g_faaj.faaj019 = l_faac016 * (g_faaj.faaj016 /100)
      #根据帐套+主要类型获取折旧科目 
      SELECT glab005 INTO g_faaj.faaj023 FROM glab_t  WHERE glabent=g_enterprise  AND glabld = g_faaj.faajld
         AND glab003 = '9901_01' AND glab002 = g_faah.faah006
      #根据帐套+主要类型获取折旧科目 
      SELECT glab005 INTO g_faaj.faaj025 FROM glab_t  WHERE glabent=g_enterprise  AND glabld = g_faaj.faajld
         AND glab003 = '9901_03' AND glab002 = g_faah.faah006
      #根据帐套+主要类型获取累折科目 
      SELECT glab005 INTO g_faaj.faaj024 FROM glab_t WHERE glabent=g_enterprise  AND glabld = g_faaj.faajld
         AND glab003 = '9901_02' AND glab002 = g_faah.faah006
      #根据帐套+主要类型获取減值準備科目 
      SELECT glab005 INTO g_faaj.faaj026 FROM glab_t WHERE glabent=g_enterprise AND glabld = g_faaj.faajld
         AND glab003 = '9901_04' AND glab002 = g_faah.faah006
             
      #帳套是否使用本位幣二
      SELECT glaa015 INTO l_glaa015 FROM glaa_t 
       WHERE glaaent = g_enterprise
         AND glaald = g_faaj.faajld
      IF l_glaa015 = 'Y' THEN
         #本位幣二 匯率類型
         SELECT glaa016,glaa018 INTO g_faaj.faaj101,l_glaa018
           FROM glaa_t
          WHERE glaaent = g_enterprise
            AND glaald = g_faaj.faajld
            
         #本位幣二 換算基準
         SELECT glaa017 INTO l_glaa017
           FROM glaa_t
          WHERE glaaent = g_enterprise
            AND glaald = g_faaj.faajld
        
         IF l_glaa017 ='1' THEN
            #本位幣二 匯率  
            CALL s_aooi160_get_exrate('2',g_faaj.faajld,l_apca.apcadocdt,g_faah.faah020,   #161221-00072#1 change g_today to l_apca.apcadocdt lujh 
                                     #目的幣別                 #匯類類型
                                     g_faaj.faaj101,0,l_glaa018)
            RETURNING g_faaj.faaj102

            #本位幣二 成本
            LET g_faaj.faaj103 =  g_faah.faah022 *  g_faaj.faaj102  
         ELSE
            #本位幣二 匯率  
            CALL s_aooi160_get_exrate('2',g_faaj.faajld,l_apca.apcadocdt,g_faaj.faaj014,   #161221-00072#1 change g_today to l_apca.apcadocdt lujh 
                                     #目的幣別                 #匯類類型
                                     g_faaj.faaj101,0,l_glaa018)
            RETURNING g_faaj.faaj102

            #本位幣二 成本
            LET g_faaj.faaj103 =  g_faah.faah024 *  g_faaj.faaj102 
         END IF
         LET g_faaj.faaj105 = g_faaj.faaj103 * l_faac016/100
         LET g_faaj.faaj104 = g_faaj.faaj017 * g_faaj.faaj102
         LET g_faaj.faaj111 = g_faaj.faaj018 * g_faaj.faaj102
         LET g_faaj.faaj108 = g_faaj.faaj028 * g_faaj.faaj102
      END IF     
      #帳套是否使用本位幣三
      SELECT glaa019 INTO l_glaa019 FROM glaa_t 
       WHERE glaaent = g_enterprise
         AND glaald = g_faaj.faajld
      IF l_glaa019 = 'Y' THEN
         #本位幣三 匯率類型
         SELECT glaa020,glaa022 INTO g_faaj.faaj151,l_glaa022
           FROM glaa_t
          WHERE glaaent = g_enterprise
            AND glaald = g_faaj.faajld
            
         #本位幣二 換算基準
         SELECT glaa021 INTO l_glaa021
           FROM glaa_t
          WHERE glaaent = g_enterprise
            AND glaald = g_faaj.faajld   
         
         IF l_glaa021 ='1' THEN
            #本位幣三 匯率  
            CALL s_aooi160_get_exrate('2',g_faaj.faajld,l_apca.apcadocdt,g_faah.faah020,   #161221-00072#1 change g_today to l_apca.apcadocdt lujh 
                                     #目的幣別                 #匯類類型
                                     g_faaj.faaj151,0,l_glaa022)
            RETURNING g_faaj.faaj152
            
            #本位幣三 成本
            LET g_faaj.faaj153 =  g_faah.faah022 *  g_faaj.faaj152  
         ELSE
            #本位幣三 匯率  
            CALL s_aooi160_get_exrate('2',g_faaj.faajld,l_apca.apcadocdt,g_faaj.faaj014,   #161221-00072#1 change g_today to l_apca.apcadocdt lujh 
                                     #目的幣別                 #匯類類型
                                     g_faaj.faaj151,0,l_glaa022)
            RETURNING g_faaj.faaj152
            
            #本位幣三 成本
            LET g_faaj.faaj153 =  g_faah.faah024 *  g_faaj.faaj152
         END IF
         LET g_faaj.faaj155 = g_faaj.faaj153 * l_faac016/100
         LET g_faaj.faaj154 = g_faaj.faaj017 * g_faaj.faaj152
         LET g_faaj.faaj161 = g_faaj.faaj018 * g_faaj.faaj152
         LET g_faaj.faaj158 = g_faaj.faaj028 * g_faaj.faaj152
      END IF     
      
   #albireo 160111-----s
   #自動編碼後要將必要4欄位存入record方便之後INSER TEMP
   LET  g_oofg001_t1   = l_apca.l_oofg001_t1 CLIPPED
   LET  g_before_code  = l_apca.l_before_code CLIPPED
   LET  g_num_code     = l_apca.l_num_code CLIPPED
   LET  g_after_code   = l_apca.l_after_code CLIPPED
   #albireo 160111-----e
   #add--2015/07/01 By shiun--(S)
   #151225-00014#1 modify-----s
    CALL s_aooi390_get_auto_no_for_successive('3',g_faah.faah003, 
                                          l_apca.l_oofg001_t1,
                                          l_apca.l_before_code, 
                                          l_apca.l_num_code, 
                                          l_apca.l_after_code)
     RETURNING l_success,g_faah.faah003 
   #CALL s_aooi390_get_auto_no('3',g_faak.faak003) RETURNING l_success,g_faak.faak003    
   #151225-00014#1 modify-----e            
   CALL s_aooi390_oofi_upd('3',g_faah.faah003) RETURNING l_success  
   LET g_faaj.faaj001 = g_faah.faah003  #160324-00036#1 add
   #add--2015/07/01 By shiun--(E)
   
   #160408-00020#3 add--str--
   SELECT faac012,faac013,faac015 
     INTO g_faah.faah054,g_faah.faah050,g_faah.faah055
     FROM faac_t
     WHERE faacent = g_enterprise AND faac001 = g_faah.faah006
   #160408-00020#3 add--end--
   #INSERT INTO faah_t VALUES(g_faah.*) #mark by geza 20161121 #161111-00028#6 
   #add by geza 20161121 #161111-00028#6 (s)   
   INSERT INTO faah_t(faahent,  faah000,  faah001,  faah002,  faah003,
                      faah004,  faah005,  faah006,  faah007,  faah008,
                      faah009,  faah010,  faah011,  faah012,  faah013,
                      faah014,  faah015,  faah016,  faah017,  faah018,
                      faah019,  faah020,  faah021,  faah022,  faah023,
                      faah024,  faah025,  faah026,  faah027,  faah028,
                      faah029,  faah030,  faah031,  faah032,  faah033,
                      faah034,  faah035,  faah036,  faah037,  faah038,
                      faah039,  faah040,  faah041,  faah042,  faah043,
                      faah044,  faah045,  faahownid,faahowndp,faahcrtid,
                      faahcrtdp,faahcrtdt,faahmodid,faahmoddt,faahstus,
                      faah046,  faah047,  faah048,  faah049,  faah050,
                      faah051,  faah052,  faah053,  faah054,  faah055,
                      faah056,  faah057,  faah058) #160426-00014#15 add faah057 faah058
               VALUES(g_faah.faahent,  g_faah.faah000,  g_faah.faah001,  g_faah.faah002,  g_faah.faah003,
                      g_faah.faah004,  g_faah.faah005,  g_faah.faah006,  g_faah.faah007,  g_faah.faah008,
                      g_faah.faah009,  g_faah.faah010,  g_faah.faah011,  g_faah.faah012,  g_faah.faah013,
                      g_faah.faah014,  g_faah.faah015,  g_faah.faah016,  g_faah.faah017,  g_faah.faah018,
                      g_faah.faah019,  g_faah.faah020,  g_faah.faah021,  g_faah.faah022,  g_faah.faah023,
                      g_faah.faah024,  g_faah.faah025,  g_faah.faah026,  g_faah.faah027,  g_faah.faah028,
                      g_faah.faah029,  g_faah.faah030,  g_faah.faah031,  g_faah.faah032,  g_faah.faah033,
                      g_faah.faah034,  g_faah.faah035,  g_faah.faah036,  g_faah.faah037,  g_faah.faah038,
                      g_faah.faah039,  g_faah.faah040,  g_faah.faah041,  g_faah.faah042,  g_faah.faah043,
                      g_faah.faah044,  g_faah.faah045,  g_faah.faahownid,g_faah.faahowndp,g_faah.faahcrtid,
                      g_faah.faahcrtdp,g_faah.faahcrtdt,g_faah.faahmodid,g_faah.faahmoddt,g_faah.faahstus,
                      g_faah.faah046,  g_faah.faah047,  g_faah.faah048,  g_faah.faah049,  g_faah.faah050,
                      g_faah.faah051,  g_faah.faah052,  g_faah.faah053,  g_faah.faah054,  g_faah.faah055,
                      g_faah.faah056,  g_faah.faah057,  g_faah.faah058) #160426-00014#15 add faah057 faah058)
   #add by geza 20161121 #161111-00028#6 (E)                   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "g_faah"
      LET g_errparam.popup = TRUE
      CALL cl_err()
  
      CALL s_transaction_end('N','0')
      LET g_success = FALSE
      RETURN g_success	
   END IF
   IF g_success = TRUE THEN 
     #INSERT INTO faaj_t VALUES(g_faaj.*) #mark by geza 20161121 #161111-00028#6 
     #add by geza 20161121 #161111-00028#6(S)
     INSERT INTO faaj_t (faajent,  faajld,   faajsite, faaj000,  faaj001,
                         faaj002,  faaj003,  faaj004,  faaj005,  faaj006,
                         faaj007,  faaj008,  faaj009,  faaj010,  faaj011,
                         faaj012,  faaj013,  faaj014,  faaj015,  faaj016,
                         faaj017,  faaj018,  faaj019,  faaj020,  faaj021,
                         faaj022,  faaj023,  faaj024,  faaj025,  faaj026,
                         faaj027,  faaj028,  faaj029,  faaj030,  faaj031,
                         faaj032,  faaj033,  faaj034,  faaj035,  faaj036,
                         faaj037,  faaj038,  faaj039,  faaj040,  faaj041,
                         faaj042,  faaj043,  faaj044,  faaj045,  faaj046,
                         faaj047,  faaj101,  faaj102,  faaj103,  faaj104,
                         faaj105,  faaj106,  faaj107,  faaj108,  faaj109,
                         faaj110,  faaj111,  faaj112,  faaj113,  faaj114,
                         faaj115,  faaj116,  faaj117,  faaj151,  faaj152,
                         faaj153,  faaj154,  faaj155,  faaj156,  faaj157,
                         faaj158,  faaj159,  faaj160,  faaj161,  faaj162,
                         faaj163,  faaj164,  faaj165,  faaj166,  faaj167,
                         faajownid,faajowndp,faajcrtid,faajcrtdp,faajcrtdt,
                         faajmodid,faajmoddt,faajstus, faaj048)
                  VALUES(g_faaj.faajent,  g_faaj.faajld,   g_faaj.faajsite, g_faaj.faaj000,  g_faaj.faaj001,
                         g_faaj.faaj002,  g_faaj.faaj003,  g_faaj.faaj004,  g_faaj.faaj005,  g_faaj.faaj006,
                         g_faaj.faaj007,  g_faaj.faaj008,  g_faaj.faaj009,  g_faaj.faaj010,  g_faaj.faaj011,
                         g_faaj.faaj012,  g_faaj.faaj013,  g_faaj.faaj014,  g_faaj.faaj015,  g_faaj.faaj016,
                         g_faaj.faaj017,  g_faaj.faaj018,  g_faaj.faaj019,  g_faaj.faaj020,  g_faaj.faaj021,
                         g_faaj.faaj022,  g_faaj.faaj023,  g_faaj.faaj024,  g_faaj.faaj025,  g_faaj.faaj026,
                         g_faaj.faaj027,  g_faaj.faaj028,  g_faaj.faaj029,  g_faaj.faaj030,  g_faaj.faaj031,
                         g_faaj.faaj032,  g_faaj.faaj033,  g_faaj.faaj034,  g_faaj.faaj035,  g_faaj.faaj036,
                         g_faaj.faaj037,  g_faaj.faaj038,  g_faaj.faaj039,  g_faaj.faaj040,  g_faaj.faaj041,
                         g_faaj.faaj042,  g_faaj.faaj043,  g_faaj.faaj044,  g_faaj.faaj045,  g_faaj.faaj046,
                         g_faaj.faaj047,  g_faaj.faaj101,  g_faaj.faaj102,  g_faaj.faaj103,  g_faaj.faaj104,
                         g_faaj.faaj105,  g_faaj.faaj106,  g_faaj.faaj107,  g_faaj.faaj108,  g_faaj.faaj109,
                         g_faaj.faaj110,  g_faaj.faaj111,  g_faaj.faaj112,  g_faaj.faaj113,  g_faaj.faaj114,
                         g_faaj.faaj115,  g_faaj.faaj116,  g_faaj.faaj117,  g_faaj.faaj151,  g_faaj.faaj152,
                         g_faaj.faaj153,  g_faaj.faaj154,  g_faaj.faaj155,  g_faaj.faaj156,  g_faaj.faaj157,
                         g_faaj.faaj158,  g_faaj.faaj159,  g_faaj.faaj160,  g_faaj.faaj161,  g_faaj.faaj162,
                         g_faaj.faaj163,  g_faaj.faaj164,  g_faaj.faaj165,  g_faaj.faaj166,  g_faaj.faaj167,
                         g_faaj.faajownid,g_faaj.faajowndp,g_faaj.faajcrtid,g_faaj.faajcrtdp,g_faaj.faajcrtdt,
                         g_faaj.faajmodid,g_faaj.faajmoddt,g_faaj.faajstus, g_faaj.faaj048)
      #add by geza 20161121 #161111-00028#6 (E)                        
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "g_faaj"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         CALL s_transaction_end('N','0')
         LET g_success = FALSE
         RETURN g_success
      END IF
   END IF   
   #add by yangxf ---
   #通過應付帳款單據+項次獲取對應來源業務單+項次
   SELECT apcb002,apcb003 INTO l_apcb002,l_apcb003
     FROM apcb_t
    WHERE apcbdocno = l_apca.apcbdocno
      AND apcbseq = l_apca.apcbseq
      AND apcbent= g_enterprise      
   #add by yangxf ---

   #產生其他帳套處理
   #在主帳套勾選的前提下產生其他帳套
   IF l_apca.b = 'Y' AND l_apca.c = 'Y' THEN  
      #IF l_apcb002 IS NOT NULL AND l_apcb003 IS NOT NULL THEN    #若主帳套的來源業務單為空，則只產生主帳套資料 #160426-00014#15 mark 
      IF g_master.f='1' AND l_apcb002 IS NOT NULL AND l_apcb003 IS NOT NULL OR g_master.f='2' THEN    #若主帳套的來源業務單為空，則只產生主帳套資料 #160426-00014#15 add
         CALL afap200_ins_faaj(g_faah.faah003,l_apca.apcbdocno,l_apca.apcbseq,l_apca.apcb015,l_apca.apcb016)  #財編于faah的財編一樣
      END IF 
   END IF
   RETURN g_success
END FUNCTION

################################################################################
# Descriptions...: 產生底稿
# Memo...........:
# Usage..........: CALL afap200_ins_faak(l_apca)
#                   
# Input parameter:  
#                :  
# Return code....:  
#                :  
# Date & Author..: 2014/2/27 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_ins_faak(l_apca)
DEFINE l_apca   type_g_apcb_d 
DEFINE l_max_faak001 LIKE faak_t.faak000
DEFINE l_ooab002 LIKE ooab_t.ooab002
DEFINE l_ooab002_1 LIKE ooab_t.ooab002
DEFINE l_apcastus LIKE apca_t.apcastus
#chenying add--str #20141123
DEFINE p_apcb015 LIKE apcb_t.apcb015
DEFINE p_apcb016 LIKE apcb_t.apcb016
#chenying add--end
DEFINE l_success LIKE type_t.num5
DEFINE l_glaa001 LIKE glaa_t.glaa001 #160426-00014#15
DEFINE l_glaa025 LIKE glaa_t.glaa025 #160426-00014#15 

   LET g_success = TRUE

   #160426-00014#15 add s---
   SELECT glaa001,glaa025 INTO l_glaa001,l_glaa025
    FROM glaa_t  
   WHERE glaaent = g_enterprise
     AND glaald = g_master.glaald 
   #160426-00014#15 add e---  
        
   INITIALIZE g_faak.* TO NULL
   LET g_faak.faakent = g_enterprise  
   LET g_faak.faakld = g_master.glaald
   LET g_faak.faak000 = l_apca.t #產生批號
  
   
   #卡片編號
   IF g_para_data = 'Y' THEN
      IF cl_null(g_faak.faak001) THEN 
         #SELECT MAX(faak001) INTO l_max_faak001 FROM faak_t WHERE faakent=g_enterprise #160905-00007#1 add           #160930-00036#1 mark
         SELECT MAX(faak001) INTO l_max_faak001 FROM faak_t WHERE faakent=g_enterprise AND faakld = g_master.glaald   #160930-00036#1 add
      ELSE
         LET l_max_faak001 = g_faak.faak001    
      END IF    
      IF l_max_faak001 IS NULL THEN LET l_max_faak001 =0 END IF
      LET g_faak.faak001 =l_max_faak001+1 USING '&&&&&&&&&&' 
   ELSE
      LET g_faak.faak001 = l_apca.faah001
   END IF

   #LET g_faak.faak002 = 1         #型態  mark by huangtao
    LET g_faak.faak002= l_apca.faah002
    
   #卡片編號與財產編號是否一致，不一致則為空
   #財產編號
#   SELECT ooab002 INTO l_ooab002_1 FROM ooab_t
#    WHERE ooabent = g_enterprise
#      AND ooab001 = 'S-FIN-9002'
#      AND ooabsite = g_site 
#   IF l_ooab002_1 = 'Y' THEN   
#      LET g_faak.faak003 = g_faak.faak001    
#   ELSE
      LET g_faak.faak003 = l_apca.faah003
#   END IF 
       
   LET g_faak.faak004 = l_apca.faah004       #附號
   LET g_faak.faak005 = 1         #資產性質
   LET g_faak.faak006 = l_apca.faah006        #資產主要類型 
   LET g_faak.faak007 = l_apca.faah007        #資產次要類型  
   LET g_faak.faak008 = ''        #資產組
   #LET g_faak.faak014 = g_today   #取得日期    #151225-00014#1 mark
   LEt g_faak.faak014 = l_apca.apcadocdt       ##151225-00014#1 add
   LET g_faak.faak015 = '0'        #資產狀態
   LET g_faak.faak009 = l_apca.apca004 #供應商
   LET g_faak.faak010 = l_apca.apca004 #製造商
   IF g_master.f = '1' THEN #160426-00014#15 add
      #規格名稱（產生編號）、單位、數量
      #項目編號、WBS  
      SELECT apcb004,apcb005,apcb006,apcb007 
        #INTO g_faak.faak012,g_faak.faak013,g_faak.faak017,g_faak.faak018  #151105-00001#3 mark
        INTO g_faak.faak013,g_faak.faak012,g_faak.faak017,g_faak.faak018   #151105-00001#3
        FROM apcb_t
       WHERE apcbent = g_enterprise 
         AND apcbld = g_master.glaald
         AND apcbdocno = l_apca.apcbdocno 
         AND apcbseq = l_apca.apcbseq
         
      #匯率、所有組織 
      SELECT apca101,apcasite INTO g_faak.faak020,g_faak.faak042 FROM apca_t
       WHERE apcaent = g_enterprise 
         AND apcald = g_master.glaald
         AND apcadocno = l_apca.apcbdocno         
   #160426-00014#15 add s---      
   ELSE
      SELECT imaal003,imaal004 INTO g_faak.faak012,g_faak.faak013 FROM imaal_t WHERE imaalent = g_enterprise AND imaal001 = l_apca.apcb004 AND imaal002 = g_dlang
      SELECT oocal003 INTO g_faak.faak017 FROM oocal_t WHERE oocalent = g_enterprise AND oocal001 = l_apca.inbb010 AND oocal002 = g_dlang
      #規格名稱（產生編號）、單位、數量
      SELECT inbb011 INTO g_faak.faak018   
        FROM inbb_t
       WHERE inbbent = g_enterprise 
         AND inbbdocno = l_apca.apcbdocno 
         AND inbbseq = l_apca.apcbseq 

      #所有組織 
      SELECT inbasite INTO g_faak.faak042 FROM inba_t
       WHERE inbaent = g_enterprise 
         AND inbadocno = l_apca.apcbdocno       
   END IF   
   #160426-00014#15 add e---
         
   LET g_faak.faak050 = l_apca.apcb015
   LET g_faak.faak051 = l_apca.apcb016       
#chenying mod--end--       
   


   SELECT faac008,faac009,faac010,faac011
     INTO g_faak.faak035,g_faak.faak036,g_faak.faak037,g_faak.faak038
     FROM faac_t
    WHERE faacent = g_enterprise
      AND faac001 = g_faak.faak006  #資產主要類型
   IF g_master.f = '1' THEN  #160426-00014#15 add   
      IF g_flag = 'Y' THEN #含税
         #原幣單價、本幣單價、原幣含税金額、本幣含税金額
       SELECT apcb101,apcb105,apcb111,apcb115,
              apcb002,apcb008    #albireo 151023 add   收貨入庫單號,採購
        INTO g_faak.faak021,g_faak.faak022,g_faak.faak023,g_faak.faak024,
             g_faak.faak040,g_faak.faak039   #albireo 151023 add     
        FROM apcb_t
       WHERE apcbent = g_enterprise 
         AND apcbld = g_master.glaald
         AND apcbdocno = l_apca.apcbdocno 
         AND apcbseq = l_apca.apcbseq
      ELSE   
       #原幣單價、本幣單價、原幣未税金額、本幣未税金額
       SELECT apcb101,apcb103,apcb111,apcb113,
              apcb002,apcb008    #albireo 151023 add   收貨入庫單號,採購
         INTO g_faak.faak021,g_faak.faak022,g_faak.faak023,g_faak.faak024,
              g_faak.faak040,g_faak.faak039   #albireo 151023 add   
        FROM apcb_t
       WHERE apcbent = g_enterprise 
         AND apcbld = g_master.glaald
         AND apcbdocno = l_apca.apcbdocno 
         AND apcbseq = l_apca.apcbseq
      END IF    
   #160426-00014#15 add s---      
   ELSE
      LET g_faak.faak022 = l_apca.xccc280_inbb011
      LET g_faak.faak024 = l_apca.xccc280_inbb011
      LET g_faak.faak021 = g_faak.faak022/g_faak.faak018
      LET g_faak.faak023 = g_faak.faak022/g_faak.faak018
   END IF
   #160426-00014#15 add e---
   
   IF g_master.f = '1' THEN   #160426-00014#15 add 
      LET g_faak.faak019 = l_apca.apca100 #幣別
   #160426-00014#15 add s---   
   ELSE
      LET g_faak.faak019 = l_glaa001
            #本位幣 匯率  
      CALL s_aooi160_get_exrate('2',g_master.glaald,g_today,g_faak.faak019,   #161221-00072#1 change g_today to  g_faaj_1.apcadocdt_1 lujh 
                                #目的幣別                 #匯類類型
                                g_faak.faak019,0,l_glaa025)
      RETURNING g_faak.faak020  
   END IF   
   #160426-00014#15 add e---
   LET g_faak.faak049 = 1         #資產屬性
   LET g_faak.faak016 = 1         #取得方式
   LET g_faak.faak043 = 'N'       #更新碼
   IF g_master.f = '1' THEN  #160426-00014#1 add
      LET g_faak.faak041 = l_apca.apcbdocno #帳款編號
      LET g_faak.faak044 = l_apca.apcbseq #帳款編號項次
   #160426-00014#1 add s---   
   ELSE
      LET g_faak.faak047 = l_apca.apcbdocno #雜發編號
      LET g_faak.faak045 = l_apca.apcbseq   #雜發編號項次      
   END IF
   #160426-00014#1 add e---
   LET g_faak.faak011 = ''        #產地
   
   LET g_faak.faakownid = g_user  #資料所有者
   LET g_faak.faakowndp = g_dept #資料所屬部門
   LET g_faak.faakcrtid = g_user  #資料建立者
   LET g_faak.faakcrtdp = g_dept #資料建立部門
   LET g_faak.faakcrtdt = g_today #資料創建日
   LET g_faak.faakstus = 'N'      #狀態碼
   LET g_faak.faak025  =g_user
#   LET g_faak.faak026  =g_dept
   SELECT ooag003 INTO g_faak.faak026
     FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = g_faak.faak025
   #存放位置
   LET g_faak.faak027 = l_apca.faah027
   LET g_faak.faak028  =g_master.ooef001
   LET g_faak.faak029  =g_user
   LET g_faak.faak030  =g_master.ooef001
   LET g_faak.faak031  =g_master.ooef001
   LET g_faak.faak032  =g_master.ooef001
   
   
  # IF g_master.a = 'N' THEN   ##151008-00017#2 add   151008-00017#3 mark
  
  #albireo 160111-----s
  #自動編碼後要將必要4欄位存入record方便之後INSER TEMP
  LET  g_oofg001_t1   = l_apca.l_oofg001_t1 CLIPPED
  LET  g_before_code  = l_apca.l_before_code CLIPPED
  LET  g_num_code     = l_apca.l_num_code CLIPPED
  LET  g_after_code   = l_apca.l_after_code CLIPPED
  #albireo 160111-----e
      #add--2015/07/01 By shiun--(S)
      #151225-00014#1 modify-----s
       CALL s_aooi390_get_auto_no_for_successive('3',l_apca.faah003,    #161117-00045#1 Mod g_faah.faah003 --> l_apca.faah003
                                             l_apca.l_oofg001_t1,
                                             l_apca.l_before_code, 
                                             l_apca.l_num_code, 
                                             l_apca.l_after_code)
        #RETURNING l_success,g_faah.faah003   #160930-00036#1 mark
        RETURNING l_success,g_faak.faak003    #160930-00036#1 add
        
        #161208-00052#1--add--str--lujh
        IF cl_null(g_faak.faak003) THEN 
           LET g_faak.faak003 = l_apca.faah003
        END IF
        #161208-00052#1--add--end--lujh
      #CALL s_aooi390_get_auto_no('3',g_faak.faak003) RETURNING l_success,g_faak.faak003    
      #151225-00014#1 modify-----e      
      CALL s_aooi390_oofi_upd('3',g_faak.faak003) RETURNING l_success
      #LET g_faaj.faaj001 = g_faah.faah003  #160324-00036#1 add   #160930-00036#1 mark
      LET g_faaj.faaj001 = g_faak.faak003                         #160930-00036#1 add
      #add--2015/07/01 By shiun--(E)
  # END IF   #151008-00017#2 add    151008-00017#3 mark
   #INSERT INTO faak_t VALUES(g_faak.*) #mark by geza 20161121 #161111-00028#6 
   #add by geza 20161121 #161111-00028#6 (S)
   INSERT INTO faak_t(faakent,  faakld,   faak000,  faak001,  faak002,
                      faak003,  faak004,  faak005,  faak006,  faak007,
                      faak008,  faak009,  faak010,  faak011,  faak012,
                      faak013,  faak014,  faak015,  faak016,  faak017,
                      faak018,  faak019,  faak020,  faak021,  faak022,
                      faak023,  faak024,  faak025,  faak026,  faak027,
                      faak028,  faak029,  faak030,  faak031,  faak032,
                      faak033,  faak034,  faak035,  faak036,  faak037,
                      faak038,  faak039,  faak040,  faak041,  faak042,
                      faak043,  faak044,  faak045,  faak046,  faak047,
                      faak048,  faak049,  faak050,  faak051,  faakownid,
                      faakowndp,faakcrtid,faakcrtdp,faakcrtdt,faakmodid,
                      faakmoddt,faakstus, faak052,  faak053,  faak054)
               VALUES(g_faak.faakent,  g_faak.faakld,   g_faak.faak000,  g_faak.faak001,  g_faak.faak002,
                      g_faak.faak003,  g_faak.faak004,  g_faak.faak005,  g_faak.faak006,  g_faak.faak007,
                      g_faak.faak008,  g_faak.faak009,  g_faak.faak010,  g_faak.faak011,  g_faak.faak012,
                      g_faak.faak013,  g_faak.faak014,  g_faak.faak015,  g_faak.faak016,  g_faak.faak017,
                      g_faak.faak018,  g_faak.faak019,  g_faak.faak020,  g_faak.faak021,  g_faak.faak022,
                      g_faak.faak023,  g_faak.faak024,  g_faak.faak025,  g_faak.faak026,  g_faak.faak027,
                      g_faak.faak028,  g_faak.faak029,  g_faak.faak030,  g_faak.faak031,  g_faak.faak032,
                      g_faak.faak033,  g_faak.faak034,  g_faak.faak035,  g_faak.faak036,  g_faak.faak037,
                      g_faak.faak038,  g_faak.faak039,  g_faak.faak040,  g_faak.faak041,  g_faak.faak042,
                      g_faak.faak043,  g_faak.faak044,  g_faak.faak045,  g_faak.faak046,  g_faak.faak047,
                      g_faak.faak048,  g_faak.faak049,  g_faak.faak050,  g_faak.faak051,  g_faak.faakownid,
                      g_faak.faakowndp,g_faak.faakcrtid,g_faak.faakcrtdp,g_faak.faakcrtdt,g_faak.faakmodid,
                      g_faak.faakmoddt,g_faak.faakstus, g_faak.faak052,  g_faak.faak053,  g_faak.faak054)
      #add by geza 20161121 #161111-00028#6 (E)                
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "g_faak"
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         CALL s_transaction_end('N','0')
         LET g_success = FALSE
         RETURN g_success	
      END IF
    RETURN g_success   
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap200_show()
# Date & Author..: 2017/02/03 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap200_show()
DEFINE l_str  STRING   
   IF g_master.f = '1' THEN 
      CALL cl_set_comp_visible('apca004',TRUE)
      CALL cl_set_comp_visible('imaal004,inbb010,oocal003,xccc280,xccc280_inbb011',FALSE) 
      LET l_str = cl_getmsg("afa-01146",g_lang)  
      CALL cl_set_comp_att_text('b_apca004',l_str) 
      LET l_str = cl_getmsg("afa-01147",g_lang)  
      CALL cl_set_comp_att_text('apca004_desc',l_str) 
      LET l_str = cl_getmsg("afa-01148",g_lang)  
      CALL cl_set_comp_att_text('apcb005',l_str)                
   ELSE
      CALL cl_set_comp_visible('apca004',FALSE) 
      CALL cl_set_comp_visible('apca100,apcb103,apcb105,apcb113,apcb115,apcb015,apcb016,apcb047',FALSE)
      CALL cl_set_comp_visible('imaal004,inbb010,oocal003,xccc280,xccc280_inbb011',TRUE)   
      LET l_str = cl_getmsg("afa-01145",g_lang)  
      CALL cl_set_comp_att_text('b_apca004',l_str)  
      LET l_str = cl_getmsg("sub-01386",g_lang)  
      CALL cl_set_comp_att_text('apca004_desc',l_str)  
      LET l_str = cl_getmsg("adb-00384",g_lang)  
      CALL cl_set_comp_att_text('apcb005',l_str)               
   END IF
END FUNCTION

#end add-point
 
{</section>}
 
