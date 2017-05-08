/* 
================================================================================
檔案代號:stkh_t
檔案名稱:招商租赁合同申请优惠费用单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stkh_t
(
stkhent       number(5)      ,/* 企业编号 */
stkhsite       varchar2(10)      ,/* 营运组织 */
stkhunit       varchar2(10)      ,/* 制定组织 */
stkhdocno       varchar2(20)      ,/* 单据编号 */
stkhseq       number(10,0)      ,/* 项次 */
stkh001       varchar2(20)      ,/* 合同编号 */
stkh002       varchar2(10)      ,/* 费用编号 */
stkh003       varchar2(20)      ,/* 优惠单号 */
stkh004       date      ,/* 开始日期 */
stkh005       date      ,/* 截止日期 */
stkh006       number(20,6)      ,/* 费用金额 */
stkh007       varchar2(10)      ,/* 合同版本 */
stkhud001       varchar2(40)      ,/* 自定义字段(文本)001 */
stkhud002       varchar2(40)      ,/* 自定义字段(文本)002 */
stkhud003       varchar2(40)      ,/* 自定义字段(文本)003 */
stkhud004       varchar2(40)      ,/* 自定义字段(文本)004 */
stkhud005       varchar2(40)      ,/* 自定义字段(文本)005 */
stkhud006       varchar2(40)      ,/* 自定义字段(文本)006 */
stkhud007       varchar2(40)      ,/* 自定义字段(文本)007 */
stkhud008       varchar2(40)      ,/* 自定义字段(文本)008 */
stkhud009       varchar2(40)      ,/* 自定义字段(文本)009 */
stkhud010       varchar2(40)      ,/* 自定义字段(文本)010 */
stkhud011       number(20,6)      ,/* 自定义字段(数字)011 */
stkhud012       number(20,6)      ,/* 自定义字段(数字)012 */
stkhud013       number(20,6)      ,/* 自定义字段(数字)013 */
stkhud014       number(20,6)      ,/* 自定义字段(数字)014 */
stkhud015       number(20,6)      ,/* 自定义字段(数字)015 */
stkhud016       number(20,6)      ,/* 自定义字段(数字)016 */
stkhud017       number(20,6)      ,/* 自定义字段(数字)017 */
stkhud018       number(20,6)      ,/* 自定义字段(数字)018 */
stkhud019       number(20,6)      ,/* 自定义字段(数字)019 */
stkhud020       number(20,6)      ,/* 自定义字段(数字)020 */
stkhud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
stkhud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
stkhud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
stkhud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
stkhud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
stkhud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
stkhud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
stkhud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
stkhud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
stkhud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
stkh008       varchar2(10)      /* 优惠类型 */
);
alter table stkh_t add constraint stkh_pk primary key (stkhent,stkhdocno,stkhseq,stkh001) enable validate;

create unique index stkh_pk on stkh_t (stkhent,stkhdocno,stkhseq,stkh001);

grant select on stkh_t to tiptop;
grant update on stkh_t to tiptop;
grant delete on stkh_t to tiptop;
grant insert on stkh_t to tiptop;

exit;
