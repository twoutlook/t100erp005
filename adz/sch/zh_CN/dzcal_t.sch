/* 
================================================================================
檔案代號:dzcal_t
檔案名稱:開窗資料表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dzcal_t
(
dzcal001       varchar2(20)      ,/* 開窗識別碼 */
dzcal002       varchar2(6)      ,/* 語言別 */
dzcal003       varchar2(500)      ,/* 說明 */
dzcal004       varchar2(10)      /* 助記碼 */
);
alter table dzcal_t add constraint dzcal_pk primary key (dzcal001,dzcal002) enable validate;

create unique index dzcal_pk on dzcal_t (dzcal001,dzcal002);

grant select on dzcal_t to tiptop;
grant update on dzcal_t to tiptop;
grant delete on dzcal_t to tiptop;
grant insert on dzcal_t to tiptop;

exit;
