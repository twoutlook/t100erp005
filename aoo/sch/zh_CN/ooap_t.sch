/* 
================================================================================
檔案代號:ooap_t
檔案名稱:BPM主帐号设置档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooap_t
(
ooapstus       varchar2(10)      ,/* 状态码 */
ooapent       number(5)      ,/* 企业编号 */
ooap001       varchar2(20)      ,/* 员工编号 */
ooap002       varchar2(20)      ,/* 用户编号 */
ooapownid       varchar2(20)      ,/* 资料所有者 */
ooapowndp       varchar2(10)      ,/* 资料所有部门 */
ooapcrtid       varchar2(20)      ,/* 资料录入者 */
ooapcrtdp       varchar2(10)      ,/* 资料录入部门 */
ooapcrtdt       timestamp(0)      ,/* 资料创建日 */
ooapmodid       varchar2(20)      ,/* 资料更改者 */
ooapmoddt       timestamp(0)      ,/* 最近更改日 */
ooapud001       varchar2(40)      ,/* 自定义字段(文本)001 */
ooapud002       varchar2(40)      ,/* 自定义字段(文本)002 */
ooapud003       varchar2(40)      ,/* 自定义字段(文本)003 */
ooapud004       varchar2(40)      ,/* 自定义字段(文本)004 */
ooapud005       varchar2(40)      ,/* 自定义字段(文本)005 */
ooapud006       varchar2(40)      ,/* 自定义字段(文本)006 */
ooapud007       varchar2(40)      ,/* 自定义字段(文本)007 */
ooapud008       varchar2(40)      ,/* 自定义字段(文本)008 */
ooapud009       varchar2(40)      ,/* 自定义字段(文本)009 */
ooapud010       varchar2(40)      ,/* 自定义字段(文本)010 */
ooapud011       number(20,6)      ,/* 自定义字段(数字)011 */
ooapud012       number(20,6)      ,/* 自定义字段(数字)012 */
ooapud013       number(20,6)      ,/* 自定义字段(数字)013 */
ooapud014       number(20,6)      ,/* 自定义字段(数字)014 */
ooapud015       number(20,6)      ,/* 自定义字段(数字)015 */
ooapud016       number(20,6)      ,/* 自定义字段(数字)016 */
ooapud017       number(20,6)      ,/* 自定义字段(数字)017 */
ooapud018       number(20,6)      ,/* 自定义字段(数字)018 */
ooapud019       number(20,6)      ,/* 自定义字段(数字)019 */
ooapud020       number(20,6)      ,/* 自定义字段(数字)020 */
ooapud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
ooapud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
ooapud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
ooapud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
ooapud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
ooapud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
ooapud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
ooapud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
ooapud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
ooapud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table ooap_t add constraint ooap_pk primary key (ooapent,ooap001) enable validate;

create unique index ooap_pk on ooap_t (ooapent,ooap001);

grant select on ooap_t to tiptop;
grant update on ooap_t to tiptop;
grant delete on ooap_t to tiptop;
grant insert on ooap_t to tiptop;

exit;
