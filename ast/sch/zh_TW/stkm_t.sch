/* 
================================================================================
檔案代號:stkm_t
檔案名稱:招商租赁合同申请合同账期单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stkm_t
(
stkment       number(5)      ,/* 企业编号 */
stkmsite       varchar2(10)      ,/* 营运组织 */
stkmunit       varchar2(10)      ,/* 制定组织 */
stkmdocno       varchar2(20)      ,/* 单据编号 */
stkmseq       number(10,0)      ,/* 项次 */
stkm001       varchar2(20)      ,/* 合同编号 */
stkm002       number(5,0)      ,/* 结算账期 */
stkm003       varchar2(10)      ,/* 费用编号 */
stkm004       date      ,/* 岀账日期 */
stkm005       date      ,/* 起始日期 */
stkm006       date      ,/* 截止日期 */
stkm007       number(20,6)      ,/* 标准费用 */
stkm008       number(20,6)      ,/* 优惠费用 */
stkm009       number(20,6)      ,/* 抹零金额 */
stkm010       number(20,6)      ,/* 终止费用 */
stkm011       number(20,6)      ,/* 实际应收 */
stkm012       number(20,6)      ,/* 已收金额 */
stkm013       number(20,6)      ,/* 未收金额 */
stkm014       number(20,6)      ,/* 清算金额 */
stkm015       varchar2(1)      ,/* 结案否 */
stkm016       varchar2(20)      ,/* 费用单号 */
stkm017       varchar2(10)      ,/* 合同版本 */
stkmud001       varchar2(40)      ,/* 自定义字段(文本)001 */
stkmud002       varchar2(40)      ,/* 自定义字段(文本)002 */
stkmud003       varchar2(40)      ,/* 自定义字段(文本)003 */
stkmud004       varchar2(40)      ,/* 自定义字段(文本)004 */
stkmud005       varchar2(40)      ,/* 自定义字段(文本)005 */
stkmud006       varchar2(40)      ,/* 自定义字段(文本)006 */
stkmud007       varchar2(40)      ,/* 自定义字段(文本)007 */
stkmud008       varchar2(40)      ,/* 自定义字段(文本)008 */
stkmud009       varchar2(40)      ,/* 自定义字段(文本)009 */
stkmud010       varchar2(40)      ,/* 自定义字段(文本)010 */
stkmud011       number(20,6)      ,/* 自定义字段(数字)011 */
stkmud012       number(20,6)      ,/* 自定义字段(数字)012 */
stkmud013       number(20,6)      ,/* 自定义字段(数字)013 */
stkmud014       number(20,6)      ,/* 自定义字段(数字)014 */
stkmud015       number(20,6)      ,/* 自定义字段(数字)015 */
stkmud016       number(20,6)      ,/* 自定义字段(数字)016 */
stkmud017       number(20,6)      ,/* 自定义字段(数字)017 */
stkmud018       number(20,6)      ,/* 自定义字段(数字)018 */
stkmud019       number(20,6)      ,/* 自定义字段(数字)019 */
stkmud020       number(20,6)      ,/* 自定义字段(数字)020 */
stkmud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
stkmud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
stkmud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
stkmud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
stkmud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
stkmud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
stkmud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
stkmud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
stkmud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
stkmud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
stkm018       varchar2(10)      ,/* 费用归属类型 */
stkm019       varchar2(10)      /* 费用归属组织 */
);
alter table stkm_t add constraint stkm_pk primary key (stkment,stkmdocno,stkmseq,stkm001) enable validate;

create unique index stkm_pk on stkm_t (stkment,stkmdocno,stkmseq,stkm001);

grant select on stkm_t to tiptop;
grant update on stkm_t to tiptop;
grant delete on stkm_t to tiptop;
grant insert on stkm_t to tiptop;

exit;
