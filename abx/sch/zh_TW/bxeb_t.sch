/* 
================================================================================
檔案代號:bxeb_t
檔案名稱:放行单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bxeb_t
(
bxebent       number(5)      ,/* 企业编号 */
bxebsite       varchar2(10)      ,/* 营运据点 */
bxebdocno       varchar2(20)      ,/* 放行申请单号 */
bxebseq       number(10,0)      ,/* 项次 */
bxeb001       varchar2(20)      ,/* 来源单号 */
bxeb002       number(10,0)      ,/* 来源项次 */
bxeb003       varchar2(40)      ,/* 料号 */
bxeb004       varchar2(10)      ,/* 单位 */
bxeb005       number(20,6)      ,/* 数量 */
bxeb006       varchar2(10)      ,/* 币种 */
bxeb007       number(20,6)      ,/* 单价 */
bxeb008       number(20,10)      ,/* 汇率 */
bxeb009       number(20,6)      /* 台币金额 */
);
alter table bxeb_t add constraint bxeb_pk primary key (bxebent,bxebdocno,bxebseq) enable validate;

create unique index bxeb_pk on bxeb_t (bxebent,bxebdocno,bxebseq);

grant select on bxeb_t to tiptop;
grant update on bxeb_t to tiptop;
grant delete on bxeb_t to tiptop;
grant insert on bxeb_t to tiptop;

exit;
