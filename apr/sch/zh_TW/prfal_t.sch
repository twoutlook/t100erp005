/* 
================================================================================
檔案代號:prfal_t
檔案名稱:客戶組申請維護作業多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table prfal_t
(
prfalent       number(5)      ,/* 企業編號 */
prfaldocno       varchar2(20)      ,/* 單據編號 */
prfal001       varchar2(6)      ,/* 語言別 */
prfal002       varchar2(500)      ,/* 說明 */
prfal003       varchar2(10)      /* 助記碼 */
);
alter table prfal_t add constraint prfal_pk primary key (prfalent,prfaldocno,prfal001) enable validate;

create unique index prfal_pk on prfal_t (prfalent,prfaldocno,prfal001);

grant select on prfal_t to tiptop;
grant update on prfal_t to tiptop;
grant delete on prfal_t to tiptop;
grant insert on prfal_t to tiptop;

exit;
