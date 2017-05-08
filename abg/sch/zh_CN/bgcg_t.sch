/* 
================================================================================
檔案代號:bgcg_t
檔案名稱:模拟收入组织对应变量主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgcg_t
(
bgcgent       number(5)      ,/* 企业编号 */
bgcg001       varchar2(10)      ,/* 预算编号 */
bgcg002       varchar2(10)      ,/* 预算组织 */
bgcg003       varchar2(10)      ,/* 仿真收入项目 */
bgcg004       varchar2(10)      ,/* 变量编号 */
bgcgownid       varchar2(20)      ,/* 资料所有者 */
bgcgowndp       varchar2(10)      ,/* 资料所有部门 */
bgcgcrtid       varchar2(20)      ,/* 资料录入者 */
bgcgcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgcgcrtdt       timestamp(0)      ,/* 资料创建日 */
bgcgmodid       varchar2(20)      ,/* 资料更改者 */
bgcgmoddt       timestamp(0)      ,/* 最近更改日 */
bgcgstus       varchar2(10)      ,/* 状态码 */
bgcgud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgcgud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgcgud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgcgud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgcgud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgcgud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgcgud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgcgud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgcgud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgcgud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgcgud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgcgud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgcgud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgcgud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgcgud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgcgud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgcgud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgcgud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgcgud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgcgud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgcgud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgcgud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgcgud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgcgud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgcgud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgcgud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgcgud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgcgud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgcgud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgcgud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgcg_t add constraint bgcg_pk primary key (bgcgent,bgcg001,bgcg002,bgcg003) enable validate;

create unique index bgcg_pk on bgcg_t (bgcgent,bgcg001,bgcg002,bgcg003);

grant select on bgcg_t to tiptop;
grant update on bgcg_t to tiptop;
grant delete on bgcg_t to tiptop;
grant insert on bgcg_t to tiptop;

exit;
