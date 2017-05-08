/* 
================================================================================
檔案代號:stkn_t
檔案名稱:招商租赁合同申请合同日核算单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stkn_t
(
stknent       number(5)      ,/* 企业编号 */
stknsite       varchar2(10)      ,/* 营运组织 */
stknunit       varchar2(10)      ,/* 制定组织 */
stkndocno       varchar2(20)      ,/* 单据编号 */
stknseq       number(10,0)      ,/* 项次 */
stkn001       varchar2(20)      ,/* 合同编号 */
stkn002       date      ,/* 分摊日期 */
stkn003       varchar2(10)      ,/* 优惠类型 */
stkn004       varchar2(10)      ,/* 数据类型 */
stkn005       varchar2(10)      ,/* 费用编号 */
stkn006       number(20,6)      ,/* 费用金额 */
stkn007       varchar2(20)      ,/* 参考单号 */
stkn008       varchar2(10)      ,/* 参考单号版本 */
stknud001       varchar2(40)      ,/* 自定义字段(文本)001 */
stknud002       varchar2(40)      ,/* 自定义字段(文本)002 */
stknud003       varchar2(40)      ,/* 自定义字段(文本)003 */
stknud004       varchar2(40)      ,/* 自定义字段(文本)004 */
stknud005       varchar2(40)      ,/* 自定义字段(文本)005 */
stknud006       varchar2(40)      ,/* 自定义字段(文本)006 */
stknud007       varchar2(40)      ,/* 自定义字段(文本)007 */
stknud008       varchar2(40)      ,/* 自定义字段(文本)008 */
stknud009       varchar2(40)      ,/* 自定义字段(文本)009 */
stknud010       varchar2(40)      ,/* 自定义字段(文本)010 */
stknud011       number(20,6)      ,/* 自定义字段(数字)011 */
stknud012       number(20,6)      ,/* 自定义字段(数字)012 */
stknud013       number(20,6)      ,/* 自定义字段(数字)013 */
stknud014       number(20,6)      ,/* 自定义字段(数字)014 */
stknud015       number(20,6)      ,/* 自定义字段(数字)015 */
stknud016       number(20,6)      ,/* 自定义字段(数字)016 */
stknud017       number(20,6)      ,/* 自定义字段(数字)017 */
stknud018       number(20,6)      ,/* 自定义字段(数字)018 */
stknud019       number(20,6)      ,/* 自定义字段(数字)019 */
stknud020       number(20,6)      ,/* 自定义字段(数字)020 */
stknud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
stknud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
stknud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
stknud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
stknud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
stknud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
stknud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
stknud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
stknud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
stknud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
stkn009       varchar2(10)      ,/* 合同版本 */
stkn010       number(10,0)      /* 合同费用项次 */
);
alter table stkn_t add constraint stkn_pk primary key (stknent,stkndocno,stknseq,stkn001) enable validate;

create unique index stkn_pk on stkn_t (stknent,stkndocno,stknseq,stkn001);

grant select on stkn_t to tiptop;
grant update on stkn_t to tiptop;
grant delete on stkn_t to tiptop;
grant insert on stkn_t to tiptop;

exit;
