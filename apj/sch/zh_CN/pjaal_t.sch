/* 
================================================================================
檔案代號:pjaal_t
檔案名稱:專案類型檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pjaal_t
(
pjaalent       number(5)      ,/* 企業編號 */
pjaal001       varchar2(10)      ,/* 專案類型 */
pjaal002       varchar2(6)      ,/* 語言別 */
pjaal003       varchar2(500)      ,/* 說明 */
pjaal004       varchar2(10)      /* 助記碼 */
);
alter table pjaal_t add constraint pjaal_pk primary key (pjaalent,pjaal001,pjaal002) enable validate;

create  index pjaal_01 on pjaal_t (pjaal004);
create unique index pjaal_pk on pjaal_t (pjaalent,pjaal001,pjaal002);

grant select on pjaal_t to tiptop;
grant update on pjaal_t to tiptop;
grant delete on pjaal_t to tiptop;
grant insert on pjaal_t to tiptop;

exit;
