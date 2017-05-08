/* 
================================================================================
檔案代號:nmdk_t
檔案名稱:銀行對帳單對帳記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmdk_t
(
nmdkent       number(5)      ,/* 企業編號 */
nmdk001       varchar2(20)      ,/* 對帳單號 */
nmdkseq       number(10,0)      ,/* 項次 */
nmdk002       varchar2(20)      ,/* 對帳流水號 */
nmdk003       varchar2(20)      ,/* 企業流水號 */
nmdk004       varchar2(1)      ,/* 對帳碼 */
nmdk005       varchar2(1)      ,/* 對帳方式 */
nmdk006       varchar2(1)      ,/* 借貸別 */
nmdk007       number(20,6)      /* 交易金額 */
);
alter table nmdk_t add constraint nmdk_pk primary key (nmdkent,nmdk001,nmdkseq) enable validate;

create unique index nmdk_pk on nmdk_t (nmdkent,nmdk001,nmdkseq);

grant select on nmdk_t to tiptop;
grant update on nmdk_t to tiptop;
grant delete on nmdk_t to tiptop;
grant insert on nmdk_t to tiptop;

exit;
