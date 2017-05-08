/* 
================================================================================
檔案代號:bgde_t
檔案名稱:预算期初库存档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bgde_t
(
bgdeent       number(5)      ,/* 企业编号 */
bgdeownid       varchar2(20)      ,/* 资料所有者 */
bgdeowndp       varchar2(10)      ,/* 资料所有部门 */
bgdecrtid       varchar2(20)      ,/* 资料录入者 */
bgdecrtdp       varchar2(10)      ,/* 资料录入部门 */
bgdecrtdt       timestamp(0)      ,/* 资料创建日 */
bgdemodid       varchar2(20)      ,/* 资料更改者 */
bgdemoddt       timestamp(0)      ,/* 最近更改日 */
bgdecnfid       varchar2(20)      ,/* 资料审核者 */
bgdecnfdt       timestamp(0)      ,/* 数据审核日 */
bgdepstid       varchar2(20)      ,/* 资料过账者 */
bgdepstdt       timestamp(0)      ,/* 资料过账日 */
bgdestus       varchar2(10)      ,/* 状态码 */
bgde001       varchar2(10)      ,/* 预算编号 */
bgde002       varchar2(10)      ,/* 预算组织 */
bgde003       varchar2(10)      ,/* 资料来源 */
bgde004       varchar2(40)      ,/* 预算料号 */
bgde005       varchar2(10)      ,/* 库存年月 */
bgde006       varchar2(10)      ,/* 成本计算类型 */
bgde007       number(20,6)      ,/* 库存数量 */
bgde008       varchar2(10)      ,/* 库存单位 */
bgde100       varchar2(10)      ,/* 预算币种 */
bgde101       number(20,10)      ,/* 汇率 */
bgde902a       number(20,6)      ,/* 库存成本-材料 */
bgde902b       number(20,6)      ,/* 库存成本-人工 */
bgde902c       number(20,6)      ,/* 库存成本-加工费 */
bgde902d       number(20,6)      ,/* 库存成本-制费一 */
bgde902e       number(20,6)      ,/* 库存成本-制费二 */
bgde902f       number(20,6)      ,/* 库存成本-制费三 */
bgde902g       number(20,6)      ,/* 库存成本-制费四 */
bgde902h       number(20,6)      ,/* 库存成本-制费五 */
bgde902       number(20,6)      ,/* 结存库存成本 */
bgdeud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgdeud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgdeud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgdeud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgdeud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgdeud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgdeud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgdeud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgdeud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgdeud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgdeud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgdeud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgdeud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgdeud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgdeud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgdeud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgdeud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgdeud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgdeud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgdeud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgdeud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgdeud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgdeud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgdeud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgdeud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgdeud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgdeud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgdeud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgdeud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgdeud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgde_t add constraint bgde_pk primary key (bgdeent,bgde001,bgde002,bgde004,bgde008) enable validate;

create unique index bgde_pk on bgde_t (bgdeent,bgde001,bgde002,bgde004,bgde008);

grant select on bgde_t to tiptop;
grant update on bgde_t to tiptop;
grant delete on bgde_t to tiptop;
grant insert on bgde_t to tiptop;

exit;
