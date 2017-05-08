/* 
================================================================================
檔案代號:bgay_t
檔案名稱:样表分配设置档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgay_t
(
bgayent       number(5)      ,/* 企业编号 */
bgayownid       varchar2(20)      ,/* 资料所有者 */
bgayowndp       varchar2(10)      ,/* 资料所有部门 */
bgaycrtid       varchar2(20)      ,/* 资料录入者 */
bgaycrtdp       varchar2(10)      ,/* 资料录入部门 */
bgaycrtdt       timestamp(0)      ,/* 资料创建日 */
bgaymodid       varchar2(20)      ,/* 资料更改者 */
bgaymoddt       timestamp(0)      ,/* 最近更改日 */
bgaystus       varchar2(10)      ,/* 状态码 */
bgay001       varchar2(10)      ,/* 预算编号 */
bgay002       varchar2(10)      ,/* 样表编号 */
bgay003       varchar2(24)      ,/* 可编制预算细项 */
bgayud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgayud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgayud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgayud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgayud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgayud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgayud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgayud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgayud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgayud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgayud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgayud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgayud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgayud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgayud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgayud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgayud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgayud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgayud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgayud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgayud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgayud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgayud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgayud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgayud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgayud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgayud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgayud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgayud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgayud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgay_t add constraint bgay_pk primary key (bgayent,bgay001,bgay002,bgay003) enable validate;

create unique index bgay_pk on bgay_t (bgayent,bgay001,bgay002,bgay003);

grant select on bgay_t to tiptop;
grant update on bgay_t to tiptop;
grant delete on bgay_t to tiptop;
grant insert on bgay_t to tiptop;

exit;
