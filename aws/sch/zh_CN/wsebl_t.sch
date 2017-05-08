/* 
================================================================================
檔案代號:wsebl_t
檔案名稱:中間庫SQL記錄表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table wsebl_t
(
wsebl001       varchar2(10)      ,/* 產品別 */
wsebl002       varchar2(80)      ,/* 查詢代號 */
wsebl003       varchar2(6)      ,/* 語言別 */
wsebl004       varchar2(500)      ,/* 說明 */
wsebl005       varchar2(10)      /* 助記碼 */
);
alter table wsebl_t add constraint wsebl_pk primary key (wsebl001,wsebl002,wsebl003) enable validate;

create unique index wsebl_pk on wsebl_t (wsebl001,wsebl002,wsebl003);

grant select on wsebl_t to tiptop;
grant update on wsebl_t to tiptop;
grant delete on wsebl_t to tiptop;
grant insert on wsebl_t to tiptop;

exit;
