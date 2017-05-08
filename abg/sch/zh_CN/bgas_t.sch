/* 
================================================================================
檔案代號:bgas_t
檔案名稱:预算料件主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgas_t
(
bgasent       number(5)      ,/* 企业编号 */
bgas001       varchar2(40)      ,/* 预算料号 */
bgas002       varchar2(40)      ,/* 参考料号 */
bgas003       varchar2(10)      ,/* 进销存/成本参考据点 */
bgas004       varchar2(10)      ,/* 主分群码 */
bgas005       varchar2(10)      ,/* 料件类别 */
bgas006       varchar2(40)      ,/* 产品特征组别 */
bgas008       varchar2(10)      ,/* 基础单位 */
bgas009       varchar2(10)      ,/* 销售分类 */
bgas010       varchar2(10)      ,/* 厂牌 */
bgas110       varchar2(10)      ,/* 销售分群 */
bgas111       varchar2(10)      ,/* 销售单位 */
bgas112       varchar2(10)      ,/* 主要客户 */
bgas113       varchar2(10)      ,/* 销售税种 */
bgas114       varchar2(10)      ,/* 销售币种 */
bgas115       number(20,6)      ,/* 标准售价 */
bgas210       varchar2(10)      ,/* 采购分群 */
bgas211       varchar2(10)      ,/* 采购单位 */
bgas212       varchar2(10)      ,/* 主供应商 */
bgas213       varchar2(10)      ,/* 采购税种 */
bgas214       varchar2(10)      ,/* 标准采购币种 */
bgas215       number(20,6)      ,/* 标准采购单价 */
bgas216       number(20,6)      ,/* 最小采购量 */
bgas217       number(20,6)      ,/* M件采购比率 */
bgas218       number(20,6)      ,/* 内采比率 */
bgas219       number(20,6)      ,/* 采购损耗率 */
bgas310       varchar2(10)      ,/* 生产单位 */
bgas311       varchar2(10)      ,/* 库存单位 */
bgas312       varchar2(10)      ,/* 发料单位 */
bgas313       number(20,6)      ,/* 安全库存量 */
bgas314       number(20,6)      ,/* 生产提前比率 */
bgas315       number(20,6)      ,/* 生产损耗率 */
bgas410       varchar2(10)      ,/* 成本分群 */
bgas411       number(5,0)      ,/* 预计成本阶数 */
bgas412       number(15,3)      ,/* 低阶码 */
bgas413       varchar2(10)      ,/* 成本币种 */
bgas414       number(15,3)      ,/* 标准工时 */
bgas415       number(15,3)      ,/* 标准机时 */
bgas416       number(20,6)      ,/* 标准单位材料成本 */
bgas417       number(20,6)      ,/* 标准单位人工成本 */
bgas418       number(20,6)      ,/* 标准单位委外加工费 */
bgas419       number(20,6)      ,/* 标准单位制造费用一 */
bgas420       number(20,6)      ,/* 标准单位制造费用二 */
bgas421       number(20,6)      ,/* 标准单位制造费用三 */
bgas422       number(20,6)      ,/* 标准单位制造费用四 */
bgas423       number(20,6)      ,/* 标准单位制造费用五 */
bgasstus       varchar2(10)      ,/* 状态码 */
bgasownid       varchar2(20)      ,/* 资料所有者 */
bgasowndp       varchar2(10)      ,/* 资料所有部门 */
bgascrtid       varchar2(20)      ,/* 资料录入者 */
bgascrtdp       varchar2(10)      ,/* 资料录入部门 */
bgascrtdt       timestamp(0)      ,/* 资料创建日 */
bgasmodid       varchar2(20)      ,/* 资料更改者 */
bgasmoddt       timestamp(0)      ,/* 最近更改日 */
bgasud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgasud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgasud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgasud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgasud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgasud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgasud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgasud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgasud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgasud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgasud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgasud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgasud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgasud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgasud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgasud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgasud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgasud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgasud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgasud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgasud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgasud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgasud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgasud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgasud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgasud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgasud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgasud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgasud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgasud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgas_t add constraint bgas_pk primary key (bgasent,bgas001) enable validate;

create unique index bgas_pk on bgas_t (bgasent,bgas001);

grant select on bgas_t to tiptop;
grant update on bgas_t to tiptop;
grant delete on bgas_t to tiptop;
grant insert on bgas_t to tiptop;

exit;
