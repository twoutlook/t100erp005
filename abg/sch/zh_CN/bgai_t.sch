/* 
================================================================================
檔案代號:bgai_t
檔案名稱:预算管理组织档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgai_t
(
bgaient       number(5)      ,/* 企业编号 */
bgaiownid       varchar2(20)      ,/* 资料所有者 */
bgaiowndp       varchar2(10)      ,/* 资料所有部门 */
bgaicrtid       varchar2(20)      ,/* 资料录入者 */
bgaicrtdp       varchar2(10)      ,/* 资料录入部门 */
bgaicrtdt       timestamp(0)      ,/* 资料创建日 */
bgaimodid       varchar2(20)      ,/* 资料更改者 */
bgaimoddt       timestamp(0)      ,/* 最近更改日 */
bgaistus       varchar2(10)      ,/* 状态码 */
bgai001       varchar2(10)      ,/* 预算编号 */
bgai002       varchar2(10)      ,/* 预算管理组织 */
bgai003       varchar2(20)      ,/* 组织成员 */
bgai004       varchar2(10)      ,/* 可操作预算组织 */
bgai005       varchar2(10)      ,/* 可操作模块 */
bgai006       varchar2(24)      ,/* 可编制预算细项 */
bgai007       varchar2(1)      ,/* 可否操作下层组织 */
bgaiud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgaiud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgaiud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgaiud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgaiud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgaiud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgaiud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgaiud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgaiud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgaiud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgaiud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgaiud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgaiud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgaiud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgaiud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgaiud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgaiud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgaiud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgaiud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgaiud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgaiud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgaiud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgaiud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgaiud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgaiud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgaiud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgaiud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgaiud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgaiud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgaiud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bgai008       varchar2(10)      /* 样表编号 */
);
alter table bgai_t add constraint bgai_pk primary key (bgaient,bgai001,bgai002,bgai003,bgai004,bgai005,bgai006) enable validate;

create unique index bgai_pk on bgai_t (bgaient,bgai001,bgai002,bgai003,bgai004,bgai005,bgai006);

grant select on bgai_t to tiptop;
grant update on bgai_t to tiptop;
grant delete on bgai_t to tiptop;
grant insert on bgai_t to tiptop;

exit;
