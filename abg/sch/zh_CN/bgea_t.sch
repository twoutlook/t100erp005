/* 
================================================================================
檔案代號:bgea_t
檔案名稱:预算组织料件主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgea_t
(
bgeaent       number(5)      ,/* 企业编号 */
bgea001       varchar2(10)      ,/* 预算编号 */
bgea002       varchar2(10)      ,/* 预算组织 */
bgea003       varchar2(40)      ,/* 预算料号 */
bgea004       varchar2(24)      ,/* 对应销售预算细项 */
bgea005       varchar2(24)      ,/* 对应采购预算细项 */
bgea006       varchar2(24)      ,/* 对应成本预算细项 */
bgea009       varchar2(10)      ,/* 销售分群 */
bgea010       varchar2(10)      ,/* 销售单位 */
bgea011       varchar2(10)      ,/* 主要客户 */
bgea012       varchar2(10)      ,/* 销售税种 */
bgea013       varchar2(10)      ,/* 销售币种 */
bgea014       number(20,6)      ,/* 标准售价 */
bgea015       varchar2(10)      ,/* 采购分群 */
bgea016       varchar2(10)      ,/* 采购单位 */
bgea017       varchar2(10)      ,/* 主供应商 */
bgea018       varchar2(10)      ,/* 采购税种 */
bgea019       varchar2(10)      ,/* 标准采购币种 */
bgea020       number(20,6)      ,/* 标准采购单价 */
bgea021       number(20,6)      ,/* 最小采购量 */
bgea022       number(20,6)      ,/* M件采购比率 */
bgea023       number(20,6)      ,/* 内采比率 */
bgea024       number(20,6)      ,/* 采购损耗率 */
bgea025       varchar2(10)      ,/* 生产单位 */
bgea026       varchar2(10)      ,/* 库存单位 */
bgea027       varchar2(10)      ,/* 发料单位 */
bgea028       number(20,6)      ,/* 安全库存量 */
bgea029       number(20,6)      ,/* 生产提前比率 */
bgea030       number(20,6)      ,/* 生产损耗率 */
bgea031       varchar2(10)      ,/* 成本分群 */
bgea032       number(5,0)      ,/* 预计成本阶数 */
bgea033       number(15,3)      ,/* 低阶码 */
bgea034       number(15,3)      ,/* 标准工时 */
bgea035       number(15,3)      ,/* 标准机时 */
bgea036       number(20,6)      ,/* 标准单位材料成本 */
bgea037       number(20,6)      ,/* 标准单位人工成本 */
bgea038       number(20,6)      ,/* 标准单位委外加工费 */
bgea039       number(20,6)      ,/* 标准单位制造费用一 */
bgea040       number(20,6)      ,/* 标准单位制造费用二 */
bgea041       number(20,6)      ,/* 标准单位制造费用三 */
bgea042       number(20,6)      ,/* 标准单位制造费用四 */
bgea043       number(20,6)      ,/* 标准单位制造费用五 */
bgea044       varchar2(10)      ,/* 成本币种 */
bgeastus       varchar2(10)      ,/* 状态码 */
bgeaownid       varchar2(20)      ,/* 资料所有者 */
bgeaowndp       varchar2(10)      ,/* 资料所有部门 */
bgeacrtid       varchar2(20)      ,/* 资料录入者 */
bgeacrtdp       varchar2(10)      ,/* 资料录入部门 */
bgeacrtdt       timestamp(0)      ,/* 资料创建日 */
bgeamodid       varchar2(20)      ,/* 资料更改者 */
bgeamoddt       timestamp(0)      ,/* 最近更改日 */
bgeaud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgeaud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgeaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgeaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgeaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgeaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgeaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgeaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgeaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgeaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgeaud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgeaud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgeaud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgeaud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgeaud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgeaud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgeaud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgeaud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgeaud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgeaud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgeaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgeaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgeaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgeaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgeaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgeaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgeaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgeaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgeaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgeaud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgea_t add constraint bgea_pk primary key (bgeaent,bgea001,bgea002,bgea003) enable validate;

create unique index bgea_pk on bgea_t (bgeaent,bgea001,bgea002,bgea003);

grant select on bgea_t to tiptop;
grant update on bgea_t to tiptop;
grant delete on bgea_t to tiptop;
grant insert on bgea_t to tiptop;

exit;
