/* 
================================================================================
檔案代號:gcaal_t
檔案名稱:券種基本資料申請檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table gcaal_t
(
gcaalent       number(5)      ,/* 企業編號 */
gcaaldocno       varchar2(20)      ,/* 單據編號 */
gcaal001       varchar2(6)      ,/* 語言別 */
gcaal002       varchar2(500)      ,/* 說明 */
gcaal003       varchar2(10)      /* 助記碼 */
);
alter table gcaal_t add constraint gcaal_pk primary key (gcaalent,gcaaldocno,gcaal001) enable validate;

create unique index gcaal_pk on gcaal_t (gcaalent,gcaaldocno,gcaal001);

grant select on gcaal_t to tiptop;
grant update on gcaal_t to tiptop;
grant delete on gcaal_t to tiptop;
grant insert on gcaal_t to tiptop;

exit;
