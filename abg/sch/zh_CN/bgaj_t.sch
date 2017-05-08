/* 
================================================================================
檔案代號:bgaj_t
檔案名稱:周期预算目录档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgaj_t
(
bgajent       number(5)      ,/* 企业编号 */
bgajownid       varchar2(20)      ,/* 资料所有者 */
bgajowndp       varchar2(10)      ,/* 资料所有部门 */
bgajcrtid       varchar2(20)      ,/* 资料录入者 */
bgajcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgajcrtdt       timestamp(0)      ,/* 资料创建日 */
bgajmodid       varchar2(20)      ,/* 资料更改者 */
bgajmoddt       timestamp(0)      ,/* 最近更改日 */
bgajstus       varchar2(10)      ,/* 状态码 */
bgaj001       varchar2(10)      ,/* 预算编号 */
bgaj002       varchar2(10)      ,/* 预算组织 */
bgaj003       varchar2(24)      ,/* 可用预算细项 */
bgajud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgajud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgajud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgajud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgajud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgajud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgajud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgajud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgajud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgajud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgajud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgajud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgajud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgajud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgajud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgajud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgajud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgajud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgajud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgajud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgajud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgajud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgajud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgajud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgajud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgajud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgajud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgajud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgajud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgajud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgaj_t add constraint bgaj_pk primary key (bgajent,bgaj001,bgaj002,bgaj003) enable validate;

create unique index bgaj_pk on bgaj_t (bgajent,bgaj001,bgaj002,bgaj003);

grant select on bgaj_t to tiptop;
grant update on bgaj_t to tiptop;
grant delete on bgaj_t to tiptop;
grant insert on bgaj_t to tiptop;

exit;
