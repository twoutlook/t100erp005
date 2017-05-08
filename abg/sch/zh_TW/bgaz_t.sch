/* 
================================================================================
檔案代號:bgaz_t
檔案名稱:预算维护档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bgaz_t
(
bgazent       number(5)      ,/* 企业编号 */
bgazownid       varchar2(20)      ,/* 资料所有者 */
bgazowndp       varchar2(10)      ,/* 资料所有部门 */
bgazcrtid       varchar2(20)      ,/* 资料录入者 */
bgazcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgazcrtdt       timestamp(0)      ,/* 资料创建日 */
bgazmodid       varchar2(20)      ,/* 资料更改者 */
bgazmoddt       timestamp(0)      ,/* 最近更改日 */
bgazstus       varchar2(10)      ,/* 状态码 */
bgaz001       varchar2(10)      ,/* 预算编号 */
bgaz002       varchar2(10)      ,/* 预算版本 */
bgaz003       varchar2(10)      ,/* 预算组织 */
bgaz004       varchar2(24)      ,/* 预算细项 */
bgaz005       varchar2(10)      ,/* 项次 */
bgaz006       number(5,0)      ,/* 预算期别 */
bgaz007       varchar2(10)      ,/* 部门 */
bgaz008       varchar2(10)      ,/* 成本利润中心 */
bgaz009       varchar2(10)      ,/* 区域 */
bgaz010       varchar2(10)      ,/* 交易客商 */
bgaz011       varchar2(10)      ,/* 收款客商 */
bgaz012       varchar2(10)      ,/* 客群 */
bgaz013       varchar2(10)      ,/* 产品分类 */
bgaz014       varchar2(20)      ,/* 人员 */
bgaz015       varchar2(20)      ,/* 项目编号 */
bgaz016       varchar2(30)      ,/* WBS */
bgaz017       varchar2(10)      ,/* 交易币种 */
bgaz018       number(20,6)      ,/* 含税单价 */
bgaz019       number(20,6)      ,/* 不含税单价 */
bgaz020       varchar2(10)      ,/* 课税类型 */
bgaz021       number(20,6)      ,/* 交易数量 */
bgaz022       number(20,6)      ,/* 交易金额 */
bgaz023       number(20,6)      ,/* 基准金额 */
bgaz024       number(20,6)      ,/* 本层调整 */
bgaz025       number(20,6)      ,/* 上层调整 */
bgaz026       number(20,6)      ,/* 下层调整 */
bgaz027       number(20,6)      ,/* 核准金额 */
bgaz028       varchar2(30)      ,/* 自由核算项一 */
bgaz029       varchar2(30)      ,/* 自由核算项二 */
bgaz030       varchar2(30)      ,/* 自由核算项三 */
bgaz031       varchar2(30)      ,/* 自由核算项四 */
bgaz032       varchar2(30)      ,/* 自由核算项五 */
bgaz033       varchar2(30)      ,/* 自由核算项六 */
bgaz034       varchar2(30)      ,/* 自由核算项七 */
bgaz035       varchar2(30)      ,/* 自由核算项八 */
bgaz036       varchar2(30)      ,/* 自由核算项九 */
bgaz037       varchar2(30)      ,/* 自由核算项十 */
bgaz038       varchar2(10)      ,/* 数据源 */
bgaz039       varchar2(10)      ,/* 自定义维度控制类型 */
bgazud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgazud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgazud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgazud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgazud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgazud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgazud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgazud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgazud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgazud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgazud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgazud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgazud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgazud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgazud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgazud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgazud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgazud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgazud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgazud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgazud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgazud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgazud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgazud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgazud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgazud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgazud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgazud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgazud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgazud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bgaz040       varchar2(10)      ,/* 经营方式 */
bgaz041       varchar2(10)      ,/* 渠道 */
bgaz042       varchar2(10)      /* 品牌 */
);
alter table bgaz_t add constraint bgaz_pk primary key (bgazent,bgaz001,bgaz002,bgaz003,bgaz004,bgaz005) enable validate;

create unique index bgaz_pk on bgaz_t (bgazent,bgaz001,bgaz002,bgaz003,bgaz004,bgaz005);

grant select on bgaz_t to tiptop;
grant update on bgaz_t to tiptop;
grant delete on bgaz_t to tiptop;
grant insert on bgaz_t to tiptop;

exit;
