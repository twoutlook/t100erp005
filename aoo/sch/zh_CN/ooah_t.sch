/* 
================================================================================
檔案代號:ooah_t
檔案名稱:员工兼职设置档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooah_t
(
ooahstus       varchar2(10)      ,/* 状态码 */
ooahent       number(5)      ,/* 企业编号 */
ooah001       varchar2(20)      ,/* 员工编号 */
ooah002       varchar2(10)      ,/* 部门编号 */
ooah003       varchar2(10)      ,/* 职称 */
ooah004       varchar2(10)      ,/* 职务核决层级 */
ooah005       varchar2(20)      ,/* 部门主管员工编号 */
ooahownid       varchar2(20)      ,/* 资料所有者 */
ooahowndp       varchar2(10)      ,/* 资料所有部门 */
ooahcrtid       varchar2(20)      ,/* 资料录入者 */
ooahcrtdp       varchar2(10)      ,/* 资料录入部门 */
ooahcrtdt       timestamp(0)      ,/* 资料创建日 */
ooahmodid       varchar2(20)      ,/* 资料更改者 */
ooahmoddt       timestamp(0)      ,/* 最近更改日 */
ooahud001       varchar2(40)      ,/* 自定义字段(文本)001 */
ooahud002       varchar2(40)      ,/* 自定义字段(文本)002 */
ooahud003       varchar2(40)      ,/* 自定义字段(文本)003 */
ooahud004       varchar2(40)      ,/* 自定义字段(文本)004 */
ooahud005       varchar2(40)      ,/* 自定义字段(文本)005 */
ooahud006       varchar2(40)      ,/* 自定义字段(文本)006 */
ooahud007       varchar2(40)      ,/* 自定义字段(文本)007 */
ooahud008       varchar2(40)      ,/* 自定义字段(文本)008 */
ooahud009       varchar2(40)      ,/* 自定义字段(文本)009 */
ooahud010       varchar2(40)      ,/* 自定义字段(文本)010 */
ooahud011       number(20,6)      ,/* 自定义字段(数字)011 */
ooahud012       number(20,6)      ,/* 自定义字段(数字)012 */
ooahud013       number(20,6)      ,/* 自定义字段(数字)013 */
ooahud014       number(20,6)      ,/* 自定义字段(数字)014 */
ooahud015       number(20,6)      ,/* 自定义字段(数字)015 */
ooahud016       number(20,6)      ,/* 自定义字段(数字)016 */
ooahud017       number(20,6)      ,/* 自定义字段(数字)017 */
ooahud018       number(20,6)      ,/* 自定义字段(数字)018 */
ooahud019       number(20,6)      ,/* 自定义字段(数字)019 */
ooahud020       number(20,6)      ,/* 自定义字段(数字)020 */
ooahud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
ooahud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
ooahud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
ooahud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
ooahud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
ooahud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
ooahud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
ooahud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
ooahud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
ooahud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
ooah006       varchar2(20)      /* 直属主管员工编号 */
);
alter table ooah_t add constraint ooah_pk primary key (ooahent,ooah001,ooah002) enable validate;

create unique index ooah_pk on ooah_t (ooahent,ooah001,ooah002);

grant select on ooah_t to tiptop;
grant update on ooah_t to tiptop;
grant delete on ooah_t to tiptop;
grant insert on ooah_t to tiptop;

exit;
