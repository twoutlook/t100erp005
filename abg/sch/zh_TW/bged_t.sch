/* 
================================================================================
檔案代號:bged_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bged_t
(
bgedent       number(5)      ,/* 企业编号 */
bged001       varchar2(10)      ,/* 预算编号 */
bged002       varchar2(10)      ,/* 预算组织 */
bged003       varchar2(10)      ,/* 预算交易对象 */
bged004       varchar2(10)      ,/* 主分群码 */
bged005       varchar2(40)      ,/* 预算料件 */
bged006       varchar2(10)      ,/* 提前期别 */
bged007       number(20,6)      ,/* 提前采购比例 */
bgedownid       varchar2(20)      ,/* 资料所有者 */
bgedowndp       varchar2(10)      ,/* 资料所有部门 */
bgedcrtid       varchar2(20)      ,/* 资料录入者 */
bgedcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgedcrtdt       timestamp(0)      ,/* 资料创建日 */
bgedmodid       varchar2(20)      ,/* 资料更改者 */
bgedmoddt       timestamp(0)      ,/* 最近更改日 */
bgedstus       varchar2(10)      ,/* 状态码 */
bgedud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgedud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgedud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgedud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgedud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgedud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgedud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgedud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgedud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgedud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgedud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgedud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgedud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgedud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgedud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgedud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgedud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgedud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgedud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgedud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgedud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgedud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgedud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgedud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgedud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgedud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgedud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgedud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgedud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgedud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bged_t add constraint bged_pk primary key (bgedent,bged001,bged002,bged003,bged004,bged005) enable validate;

create unique index bged_pk on bged_t (bgedent,bged001,bged002,bged003,bged004,bged005);

grant select on bged_t to tiptop;
grant update on bged_t to tiptop;
grant delete on bged_t to tiptop;
grant insert on bged_t to tiptop;

exit;
