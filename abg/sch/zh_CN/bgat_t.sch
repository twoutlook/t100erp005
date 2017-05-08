/* 
================================================================================
檔案代號:bgat_t
檔案名稱:预算料号对应档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgat_t
(
bgatent       number(5)      ,/* 企业编号 */
bgat001       varchar2(40)      ,/* 预算料号 */
bgat002       varchar2(40)      ,/* 对应料号 */
bgatownid       varchar2(20)      ,/* 资料所有者 */
bgatowndp       varchar2(10)      ,/* 资料所有部门 */
bgatcrtid       varchar2(20)      ,/* 资料录入者 */
bgatcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgatcrtdt       timestamp(0)      ,/* 资料创建日 */
bgatmodid       varchar2(20)      ,/* 资料更改者 */
bgatmoddt       timestamp(0)      ,/* 最近更改日 */
bgatstus       varchar2(10)      ,/* 状态码 */
bgatud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgatud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgatud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgatud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgatud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgatud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgatud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgatud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgatud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgatud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgatud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgatud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgatud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgatud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgatud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgatud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgatud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgatud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgatud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgatud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgatud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgatud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgatud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgatud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgatud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgatud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgatud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgatud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgatud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgatud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgat_t add constraint bgat_pk primary key (bgatent,bgat001,bgat002) enable validate;

create unique index bgat_pk on bgat_t (bgatent,bgat001,bgat002);

grant select on bgat_t to tiptop;
grant update on bgat_t to tiptop;
grant delete on bgat_t to tiptop;
grant insert on bgat_t to tiptop;

exit;
