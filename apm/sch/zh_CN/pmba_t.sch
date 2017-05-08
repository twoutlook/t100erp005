/* 
================================================================================
檔案代號:pmba_t
檔案名稱:交易对象准入档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmba_t
(
pmbaent       number(5)      ,/* 企业编号 */
pmbadocno       varchar2(20)      ,/* 申请单号 */
pmbadocdt       date      ,/* 申请日期 */
pmba000       varchar2(10)      ,/* 申请类别 */
pmba001       varchar2(10)      ,/* 交易对象编号 */
pmba002       varchar2(10)      ,/* 交易对象类型 */
pmba003       varchar2(20)      ,/* 交易对象税籍编号 */
pmba004       varchar2(10)      ,/* 法人类型 */
pmba005       varchar2(10)      ,/* 所属法人 */
pmba006       varchar2(10)      ,/* 所属集团 */
pmba007       varchar2(10)      ,/* 注册国家 */
pmba008       varchar2(20)      ,/* 公司登记证号 */
pmba009       varchar2(5)      ,/* 交易对象行事历参照表号 */
pmba010       varchar2(10)      ,/* 交易对象行事历类别 */
pmba011       varchar2(10)      ,/* 统计币种 */
pmba016       varchar2(80)      ,/* 负责人 */
pmba017       date      ,/* 创业日 */
pmba018       number(20,6)      ,/* 资本额 */
pmba019       varchar2(10)      ,/* 资本额计算币种 */
pmba020       number(10,0)      ,/* 员工人数 */
pmba021       number(20,6)      ,/* 年营业额 */
pmba022       varchar2(10)      ,/* 年营业额计算币种 */
pmba023       varchar2(10)      ,/* 产业分类 */
pmba024       varchar2(10)      ,/* 规模分类 */
pmba025       varchar2(255)      ,/* 主要经营产品 */
pmba026       varchar2(10)      ,/* 数据源 */
pmba027       varchar2(20)      ,/* 联络对象识别码 */
pmba036       varchar2(1)      ,/* 依交易对象结算日计算 */
pmba037       varchar2(10)      ,/* 结账方式 */
pmba038       number(5,0)      ,/* 月结日一 */
pmba039       number(5,0)      ,/* 月结日二 */
pmba040       number(5,0)      ,/* 月结日三 */
pmba041       number(5,0)      ,/* 付款日一 */
pmba042       number(5,0)      ,/* 付款日二 */
pmba043       number(5,0)      ,/* 付款日三 */
pmba044       number(5,0)      ,/* 收款日一 */
pmba045       number(5,0)      ,/* 收款日二 */
pmba046       number(5,0)      ,/* 收款日三 */
pmba047       varchar2(1)      ,/* 关系人 */
pmba051       varchar2(10)      ,/* 信用额度检查方式 */
pmba052       varchar2(10)      ,/* 额度企业 */
pmba053       varchar2(10)      ,/* 信用评核等级 */
pmba054       varchar2(10)      ,/* 额度计算币种 */
pmba055       number(20,6)      ,/* 企业额度 */
pmba056       number(20,6)      ,/* 可超出率 */
pmba057       date      ,/* 有效期限 */
pmba058       number(5,0)      ,/* 逾期账款宽限天数 */
pmba059       number(20,6)      ,/* 允许除外额度 */
pmba060       number(20,6)      ,/* no use */
pmba061       varchar2(10)      ,/* no use */
pmba062       number(20,6)      ,/* no use */
pmba063       varchar2(10)      ,/* no use */
pmba064       number(20,6)      ,/* no use */
pmba065       varchar2(10)      ,/* no use */
pmba066       varchar2(1)      ,/* no use */
pmba067       varchar2(10)      ,/* no use */
pmba068       varchar2(1)      ,/* 合并立应收付凭单 */
pmba069       varchar2(1)      ,/* 集团内账款互抵冲销 */
pmba070       varchar2(1)      ,/* 汇总开立销项发票 */
pmba071       varchar2(1)      ,/* 得以净额开立销项发票 */
pmba072       varchar2(1)      ,/* 债权移转至非同法人对象 */
pmba073       varchar2(10)      ,/* 账龄计算基准 */
pmba080       varchar2(10)      ,/* 供应商分类 */
pmba081       varchar2(10)      ,/* 供应商价格群组 */
pmba082       varchar2(10)      ,/* 供应商经营类型 */
pmba083       varchar2(10)      ,/* 供应商生命周期 */
pmba084       varchar2(10)      ,/* 供应商重要等级 */
pmba085       varchar2(10)      ,/* 供应商制定组织 */
pmba086       varchar2(20)      ,/* 默认采购员 */
pmba090       varchar2(10)      ,/* 客户分类 */
pmba091       varchar2(10)      ,/* 客户价格群组 */
pmba092       varchar2(10)      ,/* 客户经营类型 */
pmba093       varchar2(10)      ,/* 客户生命周期 */
pmba094       varchar2(10)      ,/* 客户重要等级 */
pmba095       varchar2(10)      ,/* 客户制定组织 */
pmba096       varchar2(20)      ,/* 默认业务员 */
pmba200       date      ,/* 开发日期 */
pmba201       date      ,/* 立户日期 */
pmba202       varchar2(1)      ,/* 策略联盟否 */
pmba204       varchar2(10)      ,/* 惯用经营方式 */
pmba205       varchar2(10)      ,/* 惯用下单方式 */
pmba206       varchar2(10)      ,/* 惯用结算方式 */
pmba220       varchar2(10)      ,/* 供应商角色 */
pmba221       varchar2(10)      ,/* 供应商渠道 */
pmba222       varchar2(10)      ,/* 供应商合作模式 */
pmba230       varchar2(10)      ,/* 客户性质 */
pmba231       varchar2(10)      ,/* 客户渠道 */
pmba232       varchar2(10)      ,/* 客户合作模式 */
pmba241       varchar2(10)      ,/* 经销区域 */
pmba242       varchar2(10)      ,/* 经销省区 */
pmba243       varchar2(10)      ,/* 经销县市 */
pmba244       varchar2(10)      ,/* 经销地区 */
pmba245       varchar2(10)      ,/* 擅长渠道 */
pmba246       number(20,6)      ,/* 仓库数量 */
pmba247       number(15,3)      ,/* 仓库总面积 */
pmba248       varchar2(1)      ,/* 客户库存管理否 */
pmba270       varchar2(1)      ,/* 送货周期 */
pmba271       varchar2(255)      ,/* 送货周期-日 */
pmba272       varchar2(255)      ,/* 送货周期-周 */
pmba273       varchar2(255)      ,/* No Use */
pmba274       varchar2(10)      ,/* 送货时段 */
pmba275       number(20,6)      ,/* No Use */
pmba276       number(20,6)      ,/* No Use */
pmba281       varchar2(10)      ,/* 厂商类型二 */
pmba282       varchar2(10)      ,/* 供应商其他属性二 */
pmba283       varchar2(10)      ,/* 供应商其他属性三 */
pmba284       varchar2(10)      ,/* 供应商其他属性四 */
pmba285       varchar2(10)      ,/* 供应商其他属性五 */
pmba286       varchar2(10)      ,/* 供应商其他属性六 */
pmba287       varchar2(10)      ,/* 供应商其他属性七 */
pmba288       varchar2(10)      ,/* 供应商其他属性八 */
pmba289       varchar2(10)      ,/* 供应商其他属性九 */
pmba290       varchar2(10)      ,/* 供应商其他属性十 */
pmba291       varchar2(10)      ,/* 客户其他属性一 */
pmba292       varchar2(10)      ,/* 客户其他属性二 */
pmba293       varchar2(10)      ,/* 客户其他属性三 */
pmba294       varchar2(10)      ,/* 客户其他属性四 */
pmba295       varchar2(10)      ,/* 客户其他属性五 */
pmba296       varchar2(10)      ,/* 客户其他属性六 */
pmba297       varchar2(10)      ,/* 客户其他属性七 */
pmba298       varchar2(10)      ,/* 客户其他属性八 */
pmba299       varchar2(10)      ,/* 客户其他属性九 */
pmba300       varchar2(10)      ,/* 客户其他属性十 */
pmba900       varchar2(20)      ,/* 申请人员 */
pmba901       varchar2(10)      ,/* 申请部门 */
pmbaownid       varchar2(20)      ,/* 资料所有者 */
pmbaowndp       varchar2(10)      ,/* 资料所有部门 */
pmbacrtid       varchar2(20)      ,/* 资料录入者 */
pmbacrtdp       varchar2(10)      ,/* 资料录入部门 */
pmbacrtdt       timestamp(0)      ,/* 资料创建日 */
pmbamodid       varchar2(20)      ,/* 资料更改者 */
pmbamoddt       timestamp(0)      ,/* 最近更改日 */
pmbacnfid       varchar2(20)      ,/* 资料审核者 */
pmbacnfdt       timestamp(0)      ,/* 数据审核日 */
pmbastus       varchar2(10)      ,/* 状态码 */
pmbaacti       varchar2(1)      ,/* 数据有效码 */
pmbaud001       varchar2(40)      ,/* 厂商代号 */
pmbaud002       varchar2(255)      ,/* 厂商名称 */
pmbaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
pmbaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
pmbaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
pmbaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
pmbaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
pmbaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
pmbaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
pmbaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
pmbaud011       number(20,6)      ,/* 自定义字段(数字)011 */
pmbaud012       number(20,6)      ,/* 自定义字段(数字)012 */
pmbaud013       number(20,6)      ,/* 自定义字段(数字)013 */
pmbaud014       number(20,6)      ,/* 自定义字段(数字)014 */
pmbaud015       number(20,6)      ,/* 自定义字段(数字)015 */
pmbaud016       number(20,6)      ,/* 自定义字段(数字)016 */
pmbaud017       number(20,6)      ,/* 自定义字段(数字)017 */
pmbaud018       number(20,6)      ,/* 自定义字段(数字)018 */
pmbaud019       number(20,6)      ,/* 自定义字段(数字)019 */
pmbaud020       number(20,6)      ,/* 自定义字段(数字)020 */
pmbaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
pmbaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
pmbaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
pmbaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
pmbaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
pmbaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
pmbaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
pmbaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
pmbaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
pmbaud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
pmba087       varchar2(10)      ,/* 默认采购部门 */
pmba097       varchar2(10)      ,/* 默认业务部门 */
pmba088       varchar2(1)      ,/* 寄发邮件前预览报表 */
pmba074       number(20,6)      ,/* 逾期账款宽限额度 */
pmba075       date      ,/* 除外额有效日期 */
pmba098       varchar2(1)      ,/* 是否使用EC */
pmba089       varchar2(1)      ,/* 是否列入黑名单 */
pmba028       varchar2(20)      ,/* 海关监管编号 */
pmba029       varchar2(20)      /* 保税业务人员 */
);
alter table pmba_t add constraint pmba_pk primary key (pmbaent,pmbadocno) enable validate;

create  index pmba_01 on pmba_t (pmba001);
create  index pmba_02 on pmba_t (pmba002);
create unique index pmba_pk on pmba_t (pmbaent,pmbadocno);

grant select on pmba_t to tiptop;
grant update on pmba_t to tiptop;
grant delete on pmba_t to tiptop;
grant insert on pmba_t to tiptop;

exit;
