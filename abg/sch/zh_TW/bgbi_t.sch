/* 
================================================================================
檔案代號:bgbi_t
檔案名稱:年度预算单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bgbi_t
(
bgbient       number(5)      ,/* 企业编号 */
bgbiseq       number(10,0)      ,/* 项次 */
bgbi001       varchar2(255)      ,/* 摘要 */
bgbi002       varchar2(10)      ,/* 预算编号 */
bgbi003       varchar2(10)      ,/* 预算版本 */
bgbi004       varchar2(10)      ,/* 预算组织 */
bgbi005       varchar2(24)      ,/* 预算细项 */
bgbi006       number(5,0)      ,/* 预算期别 */
bgbi007       varchar2(10)      ,/* 部门 */
bgbi008       varchar2(10)      ,/* 成本利润中心 */
bgbi009       varchar2(10)      ,/* 区域 */
bgbi010       varchar2(10)      ,/* 交易客商 */
bgbi011       varchar2(10)      ,/* 收款客商 */
bgbi012       varchar2(10)      ,/* 客群 */
bgbi013       varchar2(10)      ,/* 产品类别 */
bgbi014       varchar2(20)      ,/* 人员 */
bgbi015       varchar2(20)      ,/* 项目编号 */
bgbi016       varchar2(30)      ,/* WBS */
bgbi017       varchar2(10)      ,/* 预算币种 */
bgbi018       number(20,6)      ,/* 含税单价 */
bgbi019       number(20,6)      ,/* 不含税单价 */
bgbi020       varchar2(10)      ,/* 税种 */
bgbi021       number(20,6)      ,/* 交易数量 */
bgbi022       number(20,6)      ,/* 交易金额 */
bgbi023       number(20,6)      ,/* 基准金额 */
bgbi024       number(20,6)      ,/* 本层调整 */
bgbi025       number(20,6)      ,/* 上层调整 */
bgbi026       number(20,6)      ,/* 下层调整 */
bgbi027       number(20,6)      ,/* 核准金额 */
bgbi028       varchar2(30)      ,/* 自由核算项一 */
bgbi029       varchar2(30)      ,/* 自由核算项二 */
bgbi030       varchar2(30)      ,/* 自由核算项三 */
bgbi031       varchar2(30)      ,/* 自由核算项四 */
bgbi032       varchar2(30)      ,/* 自由核算项五 */
bgbi033       varchar2(30)      ,/* 自由核算项六 */
bgbi034       varchar2(30)      ,/* 自由核算项七 */
bgbi035       varchar2(30)      ,/* 自由核算项八 */
bgbi036       varchar2(30)      ,/* 自由核算项九 */
bgbi037       varchar2(30)      ,/* 自由核算项十 */
bgbi038       varchar2(10)      ,/* 现金变动码 */
bgbi039       varchar2(10)      ,/* 经营方式 */
bgbi040       varchar2(10)      ,/* 渠道 */
bgbi041       varchar2(10)      ,/* 品牌 */
bgbi042       number(5,2)      ,/* 税率 */
bgbi043       number(20,10)      ,/* 汇率 */
bgbiud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgbiud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgbiud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgbiud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgbiud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgbiud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgbiud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgbiud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgbiud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgbiud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgbiud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgbiud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgbiud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgbiud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgbiud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgbiud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgbiud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgbiud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgbiud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgbiud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgbiud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgbiud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgbiud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgbiud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgbiud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgbiud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgbiud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgbiud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgbiud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgbiud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bgbi044       varchar2(1)      ,/* 数据源 */
bgbi045       varchar2(10)      ,/* 管理组织 */
bgbi046       varchar2(10)      ,/* 预算样表 */
bgbiownid       varchar2(20)      ,/* 资料所有者 */
bgbiowndp       varchar2(10)      ,/* 资料所有部门 */
bgbicrtid       varchar2(20)      ,/* 资料录入者 */
bgbicrtdp       varchar2(10)      ,/* 资料录入部门 */
bgbicrtdt       timestamp(0)      ,/* 资料创建日 */
bgbimodid       varchar2(20)      ,/* 资料更改者 */
bgbimoddt       timestamp(0)      ,/* 最近更改日 */
bgbicnfid       varchar2(20)      ,/* 资料审核者 */
bgbicnfdt       timestamp(0)      ,/* 数据审核日 */
bgbistus       varchar2(10)      ,/* 状态码 */
bgbi047       varchar2(10)      /* 上层组织 */
);
alter table bgbi_t add constraint bgbi_pk primary key (bgbient,bgbiseq,bgbi002,bgbi003,bgbi004,bgbi005,bgbi006,bgbi044) enable validate;

create unique index bgbi_pk on bgbi_t (bgbient,bgbiseq,bgbi002,bgbi003,bgbi004,bgbi005,bgbi006,bgbi044);

grant select on bgbi_t to tiptop;
grant update on bgbi_t to tiptop;
grant delete on bgbi_t to tiptop;
grant insert on bgbi_t to tiptop;

exit;
