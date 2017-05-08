/* 
================================================================================
檔案代號:bgef_t
檔案名稱:对外采购分配档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgef_t
(
bgefent       number(5)      ,/* 企业编号 */
bgef001       varchar2(10)      ,/* 预算编号 */
bgef002       varchar2(10)      ,/* 预算组织 */
bgef003       number(5,0)      ,/* 期别 */
bgef004       varchar2(40)      ,/* 预算料号 */
bgef005       varchar2(10)      ,/* 供应商 */
bgef006       number(20,6)      ,/* 采购比例 */
bgefownid       varchar2(20)      ,/* 资料所有者 */
bgefowndp       varchar2(10)      ,/* 资料所有部门 */
bgefcrtid       varchar2(20)      ,/* 资料录入者 */
bgefcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgefcrtdt       timestamp(0)      ,/* 资料创建日 */
bgefmodid       varchar2(20)      ,/* 资料更改者 */
bgefmoddt       timestamp(0)      ,/* 最近更改日 */
bgefstus       varchar2(10)      ,/* 状态码 */
bgefud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgefud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgefud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgefud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgefud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgefud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgefud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgefud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgefud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgefud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgefud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgefud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgefud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgefud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgefud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgefud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgefud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgefud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgefud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgefud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgefud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgefud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgefud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgefud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgefud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgefud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgefud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgefud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgefud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgefud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgef_t add constraint bgef_pk primary key (bgefent,bgef001,bgef002,bgef003,bgef004,bgef005) enable validate;

create unique index bgef_pk on bgef_t (bgefent,bgef001,bgef002,bgef003,bgef004,bgef005);

grant select on bgef_t to tiptop;
grant update on bgef_t to tiptop;
grant delete on bgef_t to tiptop;
grant insert on bgef_t to tiptop;

exit;
