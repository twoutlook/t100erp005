/* 
================================================================================
檔案代號:bgec_t
檔案名稱:预算组织料件内采对应档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgec_t
(
bgecent       number(5)      ,/* 企业编号 */
bgec001       varchar2(10)      ,/* 预算编号 */
bgec002       varchar2(10)      ,/* 预算组织 */
bgec003       varchar2(40)      ,/* 预算料号 */
bgec004       varchar2(10)      ,/* 内采组织 */
bgec005       varchar2(10)      ,/* 据点对应交易对象编号 */
bgec006       number(20,6)      ,/* 采购比例 */
bgecownid       varchar2(20)      ,/* 资料所有者 */
bgecowndp       varchar2(10)      ,/* 资料所有部门 */
bgeccrtid       varchar2(20)      ,/* 资料录入者 */
bgeccrtdp       varchar2(10)      ,/* 资料录入部门 */
bgeccrtdt       timestamp(0)      ,/* 资料创建日 */
bgecmodid       varchar2(20)      ,/* 资料更改者 */
bgecmoddt       timestamp(0)      ,/* 最近更改日 */
bgecstus       varchar2(10)      ,/* 状态码 */
bgecud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgecud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgecud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgecud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgecud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgecud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgecud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgecud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgecud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgecud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgecud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgecud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgecud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgecud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgecud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgecud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgecud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgecud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgecud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgecud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgecud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgecud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgecud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgecud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgecud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgecud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgecud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgecud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgecud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgecud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgec_t add constraint bgec_pk primary key (bgecent,bgec001,bgec002,bgec003,bgec004) enable validate;

create unique index bgec_pk on bgec_t (bgecent,bgec001,bgec002,bgec003,bgec004);

grant select on bgec_t to tiptop;
grant update on bgec_t to tiptop;
grant delete on bgec_t to tiptop;
grant insert on bgec_t to tiptop;

exit;
