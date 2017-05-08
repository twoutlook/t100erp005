/* 
================================================================================
檔案代號:prfel_t
檔案名稱:產品價格組申請資料表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table prfel_t
(
prfelent       number(5)      ,/* 企業編號 */
prfeldocno       varchar2(20)      ,/* 申請單號 */
prfel001       varchar2(6)      ,/* 語言別 */
prfel002       varchar2(500)      ,/* 說明 */
prfel003       varchar2(10)      /* 助記碼 */
);
alter table prfel_t add constraint prfel_pk primary key (prfelent,prfeldocno,prfel001) enable validate;

create unique index prfel_pk on prfel_t (prfelent,prfeldocno,prfel001);

grant select on prfel_t to tiptop;
grant update on prfel_t to tiptop;
grant delete on prfel_t to tiptop;
grant insert on prfel_t to tiptop;

exit;
