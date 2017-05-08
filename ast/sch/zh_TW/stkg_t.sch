/* 
================================================================================
檔案代號:stkg_t
檔案名稱:招商租赁合同申请分段扣率单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stkg_t
(
stkgent       number(5)      ,/* 企业编号 */
stkgsite       varchar2(10)      ,/* 营运组织 */
stkgunit       varchar2(10)      ,/* 制定组织 */
stkgdocno       varchar2(20)      ,/* 单据编号 */
stkgseq       number(10,0)      ,/* 项次 */
stkgseq1       number(10,0)      ,/* 项序 */
stkg001       varchar2(20)      ,/* 合同编号 */
stkg002       number(20,6)      ,/* 起始金额 */
stkg003       number(20,6)      ,/* 截止金额 */
stkg004       number(20,6)      ,/* 固定/单位金额 */
stkg005       number(20,6)      ,/* 比例 */
stkgud001       varchar2(40)      ,/* 自定义字段(文本)001 */
stkgud002       varchar2(40)      ,/* 自定义字段(文本)002 */
stkgud003       varchar2(40)      ,/* 自定义字段(文本)003 */
stkgud004       varchar2(40)      ,/* 自定义字段(文本)004 */
stkgud005       varchar2(40)      ,/* 自定义字段(文本)005 */
stkgud006       varchar2(40)      ,/* 自定义字段(文本)006 */
stkgud007       varchar2(40)      ,/* 自定义字段(文本)007 */
stkgud008       varchar2(40)      ,/* 自定义字段(文本)008 */
stkgud009       varchar2(40)      ,/* 自定义字段(文本)009 */
stkgud010       varchar2(40)      ,/* 自定义字段(文本)010 */
stkgud011       number(20,6)      ,/* 自定义字段(数字)011 */
stkgud012       number(20,6)      ,/* 自定义字段(数字)012 */
stkgud013       number(20,6)      ,/* 自定义字段(数字)013 */
stkgud014       number(20,6)      ,/* 自定义字段(数字)014 */
stkgud015       number(20,6)      ,/* 自定义字段(数字)015 */
stkgud016       number(20,6)      ,/* 自定义字段(数字)016 */
stkgud017       number(20,6)      ,/* 自定义字段(数字)017 */
stkgud018       number(20,6)      ,/* 自定义字段(数字)018 */
stkgud019       number(20,6)      ,/* 自定义字段(数字)019 */
stkgud020       number(20,6)      ,/* 自定义字段(数字)020 */
stkgud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
stkgud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
stkgud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
stkgud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
stkgud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
stkgud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
stkgud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
stkgud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
stkgud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
stkgud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
stkg006       number(20,6)      ,/* 审核金额 */
stkg007       number(20,6)      /* 审核比例 */
);
alter table stkg_t add constraint stkg_pk primary key (stkgent,stkgdocno,stkgseq,stkgseq1,stkg001) enable validate;

create unique index stkg_pk on stkg_t (stkgent,stkgdocno,stkgseq,stkgseq1,stkg001);

grant select on stkg_t to tiptop;
grant update on stkg_t to tiptop;
grant delete on stkg_t to tiptop;
grant insert on stkg_t to tiptop;

exit;
