/* 
================================================================================
檔案代號:bgeb_t
檔案名稱:预算组织料号对应档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgeb_t
(
bgebent       number(5)      ,/* 企业编号 */
bgeb001       varchar2(10)      ,/* 预算编号 */
bgeb002       varchar2(10)      ,/* 预算组织 */
bgeb003       varchar2(40)      ,/* 预算料号 */
bgeb004       varchar2(40)      ,/* 对应料号 */
bgebownid       varchar2(20)      ,/* 资料所有者 */
bgebowndp       varchar2(10)      ,/* 资料所有部门 */
bgebcrtid       varchar2(20)      ,/* 资料录入者 */
bgebcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgebcrtdt       timestamp(0)      ,/* 资料创建日 */
bgebmodid       varchar2(20)      ,/* 资料更改者 */
bgebmoddt       timestamp(0)      ,/* 最近更改日 */
bgebstus       varchar2(10)      ,/* 状态码 */
bgebud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgebud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgebud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgebud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgebud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgebud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgebud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgebud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgebud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgebud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgebud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgebud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgebud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgebud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgebud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgebud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgebud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgebud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgebud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgebud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgebud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgebud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgebud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgebud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgebud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgebud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgebud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgebud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgebud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgebud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgeb_t add constraint bgeb_pk primary key (bgebent,bgeb001,bgeb002,bgeb003,bgeb004) enable validate;

create unique index bgeb_pk on bgeb_t (bgebent,bgeb001,bgeb002,bgeb003,bgeb004);

grant select on bgeb_t to tiptop;
grant update on bgeb_t to tiptop;
grant delete on bgeb_t to tiptop;
grant insert on bgeb_t to tiptop;

exit;
