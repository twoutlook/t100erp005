/* 
================================================================================
檔案代號:bgap_t
檔案名稱:预算交易对象对应档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgap_t
(
bgapent       number(5)      ,/* 企业编号 */
bgap001       varchar2(10)      ,/* 预算交易对象 */
bgap002       varchar2(1)      ,/* 交易对象类型 */
bgap003       varchar2(10)      ,/* 参考交易对象 */
bgap004       varchar2(1)      ,/* 企业内关系人 */
bgap005       varchar2(1)      ,/* 法人类型 */
bgapstus       varchar2(10)      ,/* 状态码 */
bgapownid       varchar2(20)      ,/* 资料所有者 */
bgapowndp       varchar2(10)      ,/* 资料所有部门 */
bgapcrtid       varchar2(20)      ,/* 资料录入者 */
bgapcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgapcrtdt       timestamp(0)      ,/* 资料创建日 */
bgapmodid       varchar2(20)      ,/* 资料更改者 */
bgapmoddt       timestamp(0)      ,/* 最近更改日 */
bgapud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgapud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgapud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgapud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgapud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgapud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgapud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgapud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgapud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgapud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgapud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgapud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgapud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgapud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgapud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgapud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgapud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgapud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgapud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgapud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgapud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgapud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgapud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgapud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgapud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgapud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgapud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgapud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgapud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgapud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgap_t add constraint bgap_pk primary key (bgapent,bgap001) enable validate;

create unique index bgap_pk on bgap_t (bgapent,bgap001);

grant select on bgap_t to tiptop;
grant update on bgap_t to tiptop;
grant delete on bgap_t to tiptop;
grant insert on bgap_t to tiptop;

exit;
