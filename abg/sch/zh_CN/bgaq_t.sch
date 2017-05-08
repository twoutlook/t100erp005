/* 
================================================================================
檔案代號:bgaq_t
檔案名稱:预算交易对象惯用条件档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgaq_t
(
bgaqent       number(5)      ,/* 企业编号 */
bgaq001       varchar2(10)      ,/* 预算交易对象 */
bgaq002       varchar2(1)      ,/* 对象类型 */
bgaqsite       varchar2(10)      ,/* 往来据点 */
bgaq003       varchar2(10)      ,/* 对象分类 */
bgaq004       varchar2(10)      ,/* 币种 */
bgaq005       varchar2(10)      ,/* 税种 */
bgaq006       varchar2(10)      ,/* 交易条件 */
bgaq007       varchar2(10)      ,/* 取价方式 */
bgaq008       varchar2(10)      ,/* 收付款条件 */
bgaq009       varchar2(10)      ,/* 账款类别 */
bgaq010       varchar2(10)      ,/* 渠道 */
bgaq011       varchar2(10)      ,/* 销售/采购分类 */
bgaqownid       varchar2(20)      ,/* 资料所有者 */
bgaqowndp       varchar2(10)      ,/* 资料所有部门 */
bgaqcrtid       varchar2(20)      ,/* 资料录入者 */
bgaqcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgaqcrtdt       timestamp(0)      ,/* 资料创建日 */
bgaqmodid       varchar2(20)      ,/* 资料更改者 */
bgaqmoddt       timestamp(0)      ,/* 最近更改日 */
bgaqstus       varchar2(10)      ,/* 状态码 */
bgaqud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgaqud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgaqud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgaqud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgaqud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgaqud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgaqud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgaqud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgaqud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgaqud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgaqud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgaqud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgaqud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgaqud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgaqud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgaqud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgaqud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgaqud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgaqud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgaqud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgaqud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgaqud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgaqud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgaqud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgaqud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgaqud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgaqud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgaqud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgaqud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgaqud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgaq_t add constraint bgaq_pk primary key (bgaqent,bgaq001,bgaq002,bgaqsite) enable validate;

create unique index bgaq_pk on bgaq_t (bgaqent,bgaq001,bgaq002,bgaqsite);

grant select on bgaq_t to tiptop;
grant update on bgaq_t to tiptop;
grant delete on bgaq_t to tiptop;
grant insert on bgaq_t to tiptop;

exit;
