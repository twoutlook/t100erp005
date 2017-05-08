/* 
================================================================================
檔案代號:stko_t
檔案名稱:招商租赁合同申请结算账期单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stko_t
(
stkoent       number(5)      ,/* 企业编号 */
stkosite       varchar2(10)      ,/* 营运组织 */
stkounit       varchar2(10)      ,/* 制定组织 */
stkodocno       varchar2(20)      ,/* 单据编号 */
stkoseq       number(10,0)      ,/* 结算账期 */
stko001       varchar2(20)      ,/* 合同编号 */
stko002       date      ,/* 结算日期 */
stko003       date      ,/* 起始日期 */
stko004       date      ,/* 截止日期 */
stko005       varchar2(1)      ,/* 已结算 */
stko006       varchar2(20)      ,/* 结算单号 */
stko007       varchar2(10)      /* 合同版本 */
);
alter table stko_t add constraint stko_pk primary key (stkoent,stkodocno,stkoseq,stko001) enable validate;

create unique index stko_pk on stko_t (stkoent,stkodocno,stkoseq,stko001);

grant select on stko_t to tiptop;
grant update on stko_t to tiptop;
grant delete on stko_t to tiptop;
grant insert on stko_t to tiptop;

exit;
