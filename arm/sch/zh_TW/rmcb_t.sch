/* 
================================================================================
檔案代號:rmcb_t
檔案名稱:RMA判別單單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rmcb_t
(
rmcbent       number(5)      ,/* 企業編號 */
rmcbsite       varchar2(10)      ,/* 營運據點 */
rmcbdocno       varchar2(20)      ,/* 判別單號 */
rmcbseq       number(10,0)      ,/* 項次 */
rmcb001       varchar2(20)      ,/* RMA單號 */
rmcb002       number(10,0)      ,/* RMA項次 */
rmcb003       number(10,0)      ,/* 點收項序 */
rmcb004       varchar2(40)      ,/* 料號 */
rmcb005       varchar2(256)      ,/* 產品特徵 */
rmcb006       varchar2(10)      ,/* 單位 */
rmcb007       number(20,6)      ,/* 數量 */
rmcb008       varchar2(10)      ,/* 不良原因 */
rmcb009       varchar2(1)      ,/* 判別結果 */
rmcb010       number(20,6)      ,/* 已轉數量 */
rmcb011       number(5,0)      /* 維修入庫 */
);
alter table rmcb_t add constraint rmcb_pk primary key (rmcbent,rmcbdocno,rmcbseq) enable validate;

create unique index rmcb_pk on rmcb_t (rmcbent,rmcbdocno,rmcbseq);

grant select on rmcb_t to tiptop;
grant update on rmcb_t to tiptop;
grant delete on rmcb_t to tiptop;
grant insert on rmcb_t to tiptop;

exit;
