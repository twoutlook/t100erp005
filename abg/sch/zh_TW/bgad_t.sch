/* 
================================================================================
檔案代號:bgad_t
檔案名稱:项目默认现金码档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgad_t
(
bgadent       number(5)      ,/* 企业编号 */
bgadstus       varchar2(10)      ,/* 状态码 */
bgad001       varchar2(5)      ,/* 预算细项参照表号 */
bgad002       varchar2(24)      ,/* 预算细项 */
bgad003       varchar2(20)      ,/* 现金异动码表编码 */
bgad004       varchar2(10)      ,/* 默认现金变动码 */
bgadownid       varchar2(20)      ,/* 资料所有者 */
bgadowndp       varchar2(10)      ,/* 资料所有部门 */
bgadcrtid       varchar2(20)      ,/* 资料录入者 */
bgadcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgadcrtdt       timestamp(0)      ,/* 资料创建日 */
bgadmodid       varchar2(20)      ,/* 资料更改者 */
bgadmoddt       timestamp(0)      ,/* 最近更改日 */
bgadud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgadud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgadud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgadud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgadud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgadud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgadud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgadud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgadud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgadud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgadud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgadud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgadud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgadud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgadud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgadud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgadud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgadud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgadud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgadud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgadud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgadud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgadud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgadud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgadud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgadud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgadud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgadud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgadud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgadud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgad_t add constraint bgad_pk primary key (bgadent,bgad001,bgad002,bgad003) enable validate;

create unique index bgad_pk on bgad_t (bgadent,bgad001,bgad002,bgad003);

grant select on bgad_t to tiptop;
grant update on bgad_t to tiptop;
grant delete on bgad_t to tiptop;
grant insert on bgad_t to tiptop;

exit;
