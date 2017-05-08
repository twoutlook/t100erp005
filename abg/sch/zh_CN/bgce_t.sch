/* 
================================================================================
檔案代號:bgce_t
檔案名稱:仿真收入变量主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgce_t
(
bgceent       number(5)      ,/* 企业编号 */
bgce001       varchar2(10)      ,/* 预算参照表 */
bgce002       varchar2(10)      ,/* 仿真收入项目 */
bgce003       varchar2(24)      ,/* 预算细项 */
bgcestus       varchar2(10)      ,/* 状态码 */
bgceownid       varchar2(20)      ,/* 资料所有者 */
bgceowndp       varchar2(10)      ,/* 资料所有部门 */
bgcecrtid       varchar2(20)      ,/* 资料录入者 */
bgcecrtdp       varchar2(10)      ,/* 资料录入部门 */
bgcecrtdt       timestamp(0)      ,/* 资料创建日 */
bgcemodid       varchar2(20)      ,/* 资料更改者 */
bgcemoddt       timestamp(0)      ,/* 最近更改日 */
bgceud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgceud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgceud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgceud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgceud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgceud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgceud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgceud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgceud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgceud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgceud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgceud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgceud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgceud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgceud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgceud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgceud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgceud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgceud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgceud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgceud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgceud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgceud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgceud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgceud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgceud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgceud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgceud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgceud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgceud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgce_t add constraint bgce_pk primary key (bgceent,bgce001,bgce002) enable validate;

create unique index bgce_pk on bgce_t (bgceent,bgce001,bgce002);

grant select on bgce_t to tiptop;
grant update on bgce_t to tiptop;
grant delete on bgce_t to tiptop;
grant insert on bgce_t to tiptop;

exit;
