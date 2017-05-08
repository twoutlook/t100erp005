/* 
================================================================================
檔案代號:pmaa_t
檔案名稱:交易对象主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table pmaa_t
(
pmaaent       number(5)      ,/* 企业编号 */
pmaa001       varchar2(10)      ,/* 交易对象编号 */
pmaa002       varchar2(1)      ,/* 交易对象类型 */
pmaa003       varchar2(20)      ,/* 税籍编号 */
pmaa004       varchar2(1)      ,/* 法人类型 */
pmaa005       varchar2(10)      ,/* 所属法人 */
pmaa006       varchar2(10)      ,/* 所属集团 */
pmaa007       varchar2(10)      ,/* 注册国家 */
pmaa008       varchar2(20)      ,/* 公司登记证号 */
pmaa009       varchar2(5)      ,/* 交易对象行事历参照表号 */
pmaa010       varchar2(10)      ,/* 交易对象行事历类别 */
pmaa011       varchar2(10)      ,/* 统计币种 */
pmaa016       varchar2(80)      ,/* 负责人 */
pmaa017       date      ,/* 创业日 */
pmaa018       number(20,6)      ,/* 资本额 */
pmaa019       varchar2(10)      ,/* 资本额计算币种 */
pmaa020       number(10,0)      ,/* 员工人数 */
pmaa021       number(20,6)      ,/* 年营业额 */
pmaa022       varchar2(10)      ,/* 年营业额计算币种 */
pmaa023       varchar2(10)      ,/* 产业分类 */
pmaa024       varchar2(10)      ,/* 规模分类 */
pmaa025       varchar2(255)      ,/* 主要经营产品 */
pmaa026       varchar2(10)      ,/* 数据源 */
pmaa027       varchar2(20)      ,/* 联络对象识别码 */
pmaa036       varchar2(1)      ,/* 依交易对象结算日计算 */
pmaa037       varchar2(10)      ,/* 结账方式 */
pmaa038       number(5,0)      ,/* 月结日一 */
pmaa039       number(5,0)      ,/* 月结日二 */
pmaa040       number(5,0)      ,/* 月结日三 */
pmaa041       number(5,0)      ,/* 付款日一 */
pmaa042       number(5,0)      ,/* 付款日二 */
pmaa043       number(5,0)      ,/* 付款日三 */
pmaa044       number(5,0)      ,/* 收款日一 */
pmaa045       number(5,0)      ,/* 收款日二 */
pmaa046       number(5,0)      ,/* 收款日三 */
pmaa047       varchar2(1)      ,/* 关系人 */
pmaa051       varchar2(10)      ,/* 信用额度检查方式 */
pmaa052       varchar2(10)      ,/* 额度企业 */
pmaa053       varchar2(10)      ,/* 信用评核等级 */
pmaa054       varchar2(10)      ,/* 额度计算币种 */
pmaa055       number(20,6)      ,/* 企业额度 */
pmaa056       number(20,6)      ,/* 可超出率 */
pmaa057       date      ,/* 有效期限 */
pmaa058       number(5,0)      ,/* 逾期账款宽限天数 */
pmaa059       number(20,6)      ,/* 允许除外额 */
pmaa060       number(20,6)      ,/* no use */
pmaa061       varchar2(10)      ,/* no use */
pmaa062       number(20,6)      ,/* no use */
pmaa063       varchar2(10)      ,/* no use */
pmaa064       number(20,6)      ,/* no use */
pmaa065       varchar2(10)      ,/* no use */
pmaa066       varchar2(1)      ,/* no use */
pmaa067       varchar2(10)      ,/* no use */
pmaa068       varchar2(1)      ,/* 合并立应收付凭单 */
pmaa069       varchar2(1)      ,/* 集团内账款互抵冲销 */
pmaa070       varchar2(1)      ,/* 汇总开立销项发票 */
pmaa071       varchar2(1)      ,/* 得以净额开立销项发票 */
pmaa072       varchar2(1)      ,/* 债权移转至非同法人对象 */
pmaa073       varchar2(10)      ,/* 账龄计算基准 */
pmaa080       varchar2(10)      ,/* 供应商分类 */
pmaa081       varchar2(10)      ,/* 供应商价格群组 */
pmaa082       varchar2(10)      ,/* 供应商经营类型 */
pmaa083       varchar2(10)      ,/* 供应商生命周期 */
pmaa084       varchar2(10)      ,/* 供应商重要性等级 */
pmaa085       varchar2(10)      ,/* 供应商制定组织 */
pmaa086       varchar2(20)      ,/* 默认采购员 */
pmaa090       varchar2(10)      ,/* 客户分类 */
pmaa091       varchar2(10)      ,/* 客户价格群组 */
pmaa092       varchar2(10)      ,/* 客户经营类型 */
pmaa093       varchar2(10)      ,/* 客户生命周期 */
pmaa094       varchar2(10)      ,/* 客户重要等级 */
pmaa095       varchar2(10)      ,/* 客户制定组织 */
pmaa096       varchar2(20)      ,/* 默认业务员 */
pmaa200       date      ,/* 开发日期 */
pmaa201       date      ,/* 立户日期 */
pmaa202       varchar2(1)      ,/* 策略联盟否 */
pmaa204       varchar2(10)      ,/* 惯用经营方式 */
pmaa205       varchar2(10)      ,/* 惯用下单方式 */
pmaa206       varchar2(10)      ,/* 惯用结算方式 */
pmaa220       varchar2(10)      ,/* 供应商角色 */
pmaa221       varchar2(10)      ,/* 供应商渠道 */
pmaa222       varchar2(10)      ,/* 供应商合作模式 */
pmaa230       varchar2(10)      ,/* 客户性质 */
pmaa231       varchar2(10)      ,/* 客户渠道 */
pmaa232       varchar2(10)      ,/* 客户合作模式 */
pmaa241       varchar2(10)      ,/* 经销区域 */
pmaa242       varchar2(10)      ,/* 经销省区 */
pmaa243       varchar2(10)      ,/* 经销县市 */
pmaa244       varchar2(10)      ,/* 经销地区 */
pmaa245       varchar2(10)      ,/* 擅长渠道 */
pmaa246       number(20,6)      ,/* 仓库数量 */
pmaa247       number(15,3)      ,/* 仓库总面积 */
pmaa248       varchar2(1)      ,/* 客户库存管理否 */
pmaa270       varchar2(1)      ,/* 送货周期 */
pmaa271       varchar2(255)      ,/* 送货周期-日 */
pmaa272       varchar2(255)      ,/* 送货周期-周 */
pmaa273       varchar2(255)      ,/* no use */
pmaa274       varchar2(10)      ,/* 送货时段 */
pmaa275       number(20,6)      ,/* no use */
pmaa276       number(20,6)      ,/* no use */
pmaa281       varchar2(10)      ,/* 厂商类型二 */
pmaa282       varchar2(10)      ,/* 供应商其他属性二 */
pmaa283       varchar2(10)      ,/* 供应商其他属性三 */
pmaa284       varchar2(10)      ,/* 供应商其他属性四 */
pmaa285       varchar2(10)      ,/* 供应商其他属性五 */
pmaa286       varchar2(10)      ,/* 供应商其他属性六 */
pmaa287       varchar2(10)      ,/* 供应商其他属性七 */
pmaa288       varchar2(10)      ,/* 供应商其他属性八 */
pmaa289       varchar2(10)      ,/* 供应商其他属性九 */
pmaa290       varchar2(10)      ,/* 供应商其他属性十 */
pmaa291       varchar2(10)      ,/* 客户其他属性一 */
pmaa292       varchar2(10)      ,/* 客户其他属性二 */
pmaa293       varchar2(10)      ,/* 客户其他属性三 */
pmaa294       varchar2(10)      ,/* 客户其他属性四 */
pmaa295       varchar2(10)      ,/* 客户其他属性五 */
pmaa296       varchar2(10)      ,/* 客户其他属性六 */
pmaa297       varchar2(10)      ,/* 客户其他属性七 */
pmaa298       varchar2(10)      ,/* 客户其他属性八 */
pmaa299       varchar2(10)      ,/* 客户其他属性九 */
pmaa300       varchar2(10)      ,/* 客户其他属性十 */
pmaaownid       varchar2(20)      ,/* 资料所有者 */
pmaaowndp       varchar2(10)      ,/* 资料所有部门 */
pmaacrtid       varchar2(20)      ,/* 资料录入者 */
pmaacrtdp       varchar2(10)      ,/* 资料录入部门 */
pmaacrtdt       timestamp(0)      ,/* 资料创建日 */
pmaamodid       varchar2(20)      ,/* 资料更改者 */
pmaamoddt       timestamp(0)      ,/* 最近更改日 */
pmaacnfid       varchar2(20)      ,/* 资料审核者 */
pmaacnfdt       timestamp(0)      ,/* 数据审核日 */
pmaastus       varchar2(10)      ,/* 状态码 */
pmaaud001       varchar2(40)      ,/* 厂商代号 */
pmaaud002       varchar2(255)      ,/* 厂商名称 */
pmaaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
pmaaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
pmaaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
pmaaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
pmaaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
pmaaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
pmaaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
pmaaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
pmaaud011       number(20,6)      ,/* 自定义字段(数字)011 */
pmaaud012       number(20,6)      ,/* 自定义字段(数字)012 */
pmaaud013       number(20,6)      ,/* 自定义字段(数字)013 */
pmaaud014       number(20,6)      ,/* 自定义字段(数字)014 */
pmaaud015       number(20,6)      ,/* 自定义字段(数字)015 */
pmaaud016       number(20,6)      ,/* 自定义字段(数字)016 */
pmaaud017       number(20,6)      ,/* 自定义字段(数字)017 */
pmaaud018       number(20,6)      ,/* 自定义字段(数字)018 */
pmaaud019       number(20,6)      ,/* 自定义字段(数字)019 */
pmaaud020       number(20,6)      ,/* 自定义字段(数字)020 */
pmaaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
pmaaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
pmaaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
pmaaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
pmaaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
pmaaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
pmaaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
pmaaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
pmaaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
pmaaud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
pmaa087       varchar2(10)      ,/* 默认采购部门 */
pmaa097       varchar2(10)      ,/* 默认业务部门 */
pmaa088       varchar2(1)      ,/* 寄发邮件前预览报表 */
pmaa074       number(20,6)      ,/* 逾期账款宽限额度 */
pmaa075       date      ,/* 除外额有效日期 */
pmaa098       varchar2(1)      ,/* 是否使用EC */
pmaa089       varchar2(1)      ,/* 是否列入黑名单 */
pmaa028       varchar2(20)      ,/* 海关监管编号 */
pmaa029       varchar2(20)      /* 保税业务人员 */
);
alter table pmaa_t add constraint pmaa_pk primary key (pmaaent,pmaa001) enable validate;

create unique index pmaa_pk on pmaa_t (pmaaent,pmaa001);

grant select on pmaa_t to tiptop;
grant update on pmaa_t to tiptop;
grant delete on pmaa_t to tiptop;
grant insert on pmaa_t to tiptop;

exit;
