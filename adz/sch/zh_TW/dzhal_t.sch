/* 
================================================================================
檔案代號:dzhal_t
檔案名稱:資料表主檔簽出備份檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dzhal_t
(
dzhal000       varchar2(40)      ,/* 簽出GUID */
dzhal001       varchar2(15)      ,/* table代號 */
dzhal002       varchar2(6)      ,/* 語言別 */
dzhal003       varchar2(500)      ,/* 說明 */
dzhal004       varchar2(10)      /* 助記碼 */
);
alter table dzhal_t add constraint dzhal_pk primary key (dzhal000,dzhal001,dzhal002) enable validate;

create unique index dzhal_pk on dzhal_t (dzhal000,dzhal001,dzhal002);

grant select on dzhal_t to tiptop;
grant update on dzhal_t to tiptop;
grant delete on dzhal_t to tiptop;
grant insert on dzhal_t to tiptop;

exit;
