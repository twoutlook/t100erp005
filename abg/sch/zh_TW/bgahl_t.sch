/* 
================================================================================
檔案代號:bgahl_t
檔案名稱:預算組織檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bgahl_t
(
bgahlent       number(5)      ,/* 企業編號 */
bgahl001       varchar2(10)      ,/* 版本 */
bgahl004       varchar2(10)      ,/* 預算組織編號 */
bgahl005       varchar2(6)      ,/* 語言別 */
bgahl006       varchar2(500)      ,/* 說明 */
bgahl007       varchar2(10)      /* 助記碼 */
);
alter table bgahl_t add constraint bgahl_pk primary key (bgahlent,bgahl001,bgahl004,bgahl005) enable validate;

create unique index bgahl_pk on bgahl_t (bgahlent,bgahl001,bgahl004,bgahl005);

grant select on bgahl_t to tiptop;
grant update on bgahl_t to tiptop;
grant delete on bgahl_t to tiptop;
grant insert on bgahl_t to tiptop;

exit;
