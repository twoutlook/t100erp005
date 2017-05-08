/* 
================================================================================
檔案代號:ookbl_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table ookbl_t
(
ookblent       number(5)      ,/* 企業代碼 */
ookbl001       varchar2(10)      ,/* 目錄編號 */
ookbl002       varchar2(6)      ,/* 語言別 */
ookbl003       varchar2(500)      ,/* 說明 */
ookbl004       varchar2(10)      /* 助記碼 */
);
alter table ookbl_t add constraint ookbl_pk primary key (ookblent,ookbl001,ookbl002) enable validate;

create unique index ookbl_pk on ookbl_t (ookblent,ookbl001,ookbl002);

grant select on ookbl_t to tiptop;
grant update on ookbl_t to tiptop;
grant delete on ookbl_t to tiptop;
grant insert on ookbl_t to tiptop;

exit;
