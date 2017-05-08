/* 
================================================================================
檔案代號:bggc_t
檔案名稱:工资组织数据档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bggc_t
(
bggcent       number(5)      ,/* 企业编号 */
bggc001       varchar2(10)      ,/* 预算编号 */
bggc002       varchar2(10)      ,/* 预算组织 */
bggc003       varchar2(10)      ,/* 一般编号 */
bggc004       varchar2(10)      ,/* 原因码 */
bggc005       varchar2(24)      ,/* 借方预算细项 */
bggc006       varchar2(24)      ,/* 贷方预算细项 */
bggcownid       varchar2(20)      ,/* 资料所有者 */
bggcowndp       varchar2(10)      ,/* 资料所有部门 */
bggccrtid       varchar2(20)      ,/* 资料录入者 */
bggccrtdp       varchar2(10)      ,/* 资料录入部门 */
bggccrtdt       timestamp(0)      ,/* 资料创建日 */
bggcmodid       varchar2(20)      ,/* 资料更改者 */
bggcmoddt       timestamp(0)      ,/* 最近更改日 */
bggcstus       varchar2(10)      ,/* 状态码 */
bggcud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bggcud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bggcud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bggcud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bggcud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bggcud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bggcud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bggcud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bggcud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bggcud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bggcud011       number(20,6)      ,/* 自定义字段(数字)011 */
bggcud012       number(20,6)      ,/* 自定义字段(数字)012 */
bggcud013       number(20,6)      ,/* 自定义字段(数字)013 */
bggcud014       number(20,6)      ,/* 自定义字段(数字)014 */
bggcud015       number(20,6)      ,/* 自定义字段(数字)015 */
bggcud016       number(20,6)      ,/* 自定义字段(数字)016 */
bggcud017       number(20,6)      ,/* 自定义字段(数字)017 */
bggcud018       number(20,6)      ,/* 自定义字段(数字)018 */
bggcud019       number(20,6)      ,/* 自定义字段(数字)019 */
bggcud020       number(20,6)      ,/* 自定义字段(数字)020 */
bggcud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bggcud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bggcud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bggcud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bggcud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bggcud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bggcud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bggcud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bggcud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bggcud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bggc_t add constraint bggc_pk primary key (bggcent,bggc001,bggc002,bggc003,bggc004) enable validate;

create unique index bggc_pk on bggc_t (bggcent,bggc001,bggc002,bggc003,bggc004);

grant select on bggc_t to tiptop;
grant update on bggc_t to tiptop;
grant delete on bggc_t to tiptop;
grant insert on bggc_t to tiptop;

exit;
