/* 
================================================================================
檔案代號:bgar_t
檔案名稱:预算交易对象对应档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgar_t
(
bgarent       number(5)      ,/* 企业编号 */
bgar001       varchar2(10)      ,/* 预算交易对象 */
bgar002       varchar2(10)      ,/* 交易对象 */
bgarownid       varchar2(20)      ,/* 资料所有者 */
bgarowndp       varchar2(10)      ,/* 资料所有部门 */
bgarcrtid       varchar2(20)      ,/* 资料录入者 */
bgarcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgarcrtdt       timestamp(0)      ,/* 资料创建日 */
bgarmodid       varchar2(20)      ,/* 资料更改者 */
bgarmoddt       timestamp(0)      ,/* 最近更改日 */
bgarstus       varchar2(10)      ,/* 状态码 */
bgarud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgarud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgarud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgarud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgarud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgarud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgarud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgarud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgarud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgarud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgarud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgarud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgarud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgarud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgarud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgarud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgarud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgarud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgarud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgarud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgarud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgarud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgarud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgarud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgarud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgarud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgarud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgarud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgarud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgarud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgar_t add constraint bgar_pk primary key (bgarent,bgar001,bgar002) enable validate;

create unique index bgar_pk on bgar_t (bgarent,bgar001,bgar002);

grant select on bgar_t to tiptop;
grant update on bgar_t to tiptop;
grant delete on bgar_t to tiptop;
grant insert on bgar_t to tiptop;

exit;
