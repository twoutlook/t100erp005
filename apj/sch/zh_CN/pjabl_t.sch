/* 
================================================================================
檔案代號:pjabl_t
檔案名稱:專案立項檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pjabl_t
(
pjablent       number(5)      ,/* 企業編號 */
pjabl001       varchar2(20)      ,/* 專案編號 */
pjabl002       varchar2(6)      ,/* 語言別 */
pjabl003       varchar2(500)      ,/* 說明 */
pjabl004       varchar2(10)      /* 助記碼 */
);
alter table pjabl_t add constraint pjabl_pk primary key (pjablent,pjabl001,pjabl002) enable validate;

create unique index pjabl_pk on pjabl_t (pjablent,pjabl001,pjabl002);

grant select on pjabl_t to tiptop;
grant update on pjabl_t to tiptop;
grant delete on pjabl_t to tiptop;
grant insert on pjabl_t to tiptop;

exit;
