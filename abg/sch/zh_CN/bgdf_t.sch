/* 
================================================================================
檔案代號:bgdf_t
檔案名稱:预算期初实际料件库存档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bgdf_t
(
bgdfent       number(5)      ,/* 企业编号 */
bgdf001       varchar2(10)      ,/* 预算编号 */
bgdf002       varchar2(10)      ,/* 预算组织 */
bgdf003       varchar2(40)      ,/* 预算料号 */
bgdf004       varchar2(40)      ,/* 实际料件 */
bgdf005       varchar2(10)      ,/* 库存单位 */
bgdf006       varchar2(10)      ,/* 库存年月 */
bgdf007       number(20,6)      ,/* 库存数量 */
bgdf008       varchar2(10)      ,/* 上阶料件 */
bgdf009       number(20,6)      ,/* 单位转换率 */
bgdf100       varchar2(10)      ,/* 本位币种 */
bgdf902a       number(20,6)      ,/* 库存成本-材料 */
bgdf902b       number(20,6)      ,/* 库存成本-人工 */
bgdf902c       number(20,6)      ,/* 库存成本-加工 */
bgdf902d       number(20,6)      ,/* 库存成本-制费一 */
bgdf902e       number(20,6)      ,/* 库存成本-制费二 */
bgdf902f       number(20,6)      ,/* 库存成本-制费三 */
bgdf902g       number(20,6)      ,/* 库存成本-制费四 */
bgdf902h       number(20,6)      ,/* 库存成本-制费五 */
bgdf902       number(20,6)      ,/* 库存成本 */
bgdfud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgdfud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgdfud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgdfud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgdfud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgdfud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgdfud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgdfud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgdfud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgdfud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgdfud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgdfud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgdfud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgdfud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgdfud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgdfud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgdfud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgdfud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgdfud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgdfud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgdfud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgdfud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgdfud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgdfud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgdfud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgdfud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgdfud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgdfud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgdfud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgdfud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgdf_t add constraint bgdf_pk primary key (bgdfent,bgdf001,bgdf002,bgdf003,bgdf004,bgdf008) enable validate;

create unique index bgdf_pk on bgdf_t (bgdfent,bgdf001,bgdf002,bgdf003,bgdf004,bgdf008);

grant select on bgdf_t to tiptop;
grant update on bgdf_t to tiptop;
grant delete on bgdf_t to tiptop;
grant insert on bgdf_t to tiptop;

exit;
