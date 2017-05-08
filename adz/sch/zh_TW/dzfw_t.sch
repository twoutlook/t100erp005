/* 
================================================================================
檔案代號:dzfw_t
檔案名稱:樹狀結構屬性設定檔底稿
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfw_t
(
dzfw001       varchar2(20)      ,/* 設計工具版號 */
dzfw002       varchar2(20)      ,/* 資料所有者 */
dzfw003       varchar2(20)      ,/* 程式代號 */
dzfw004       varchar2(40)      ,/* 4fd tag name */
dzfw005       number(5,0)      ,/* 編號 */
dzfw006       varchar2(20)      ,/* 屬性 */
dzfw007       varchar2(15)      ,/* 資料表代碼 */
dzfw008       varchar2(20)      /* 欄位代號 */
);
alter table dzfw_t add constraint dzfw_pk primary key (dzfw001,dzfw002,dzfw003,dzfw004,dzfw005) enable validate;

create unique index dzfw_pk on dzfw_t (dzfw001,dzfw002,dzfw003,dzfw004,dzfw005);

grant select on dzfw_t to tiptop;
grant update on dzfw_t to tiptop;
grant delete on dzfw_t to tiptop;
grant insert on dzfw_t to tiptop;

exit;
