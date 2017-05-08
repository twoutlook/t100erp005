/* 
================================================================================
檔案代號:bgafl_t
檔案名稱:預算變量多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table bgafl_t
(
bgaflent       number(5)      ,/* 企業編號 */
bgafl001       varchar2(10)      ,/* 預算變量編號 */
bgafl002       varchar2(6)      ,/* 語言別 */
bgafl003       varchar2(500)      ,/* 說明 */
bgafl004       varchar2(10)      ,/* 助記碼 */
bgafl005       varchar2(5)      /* 預算項目組別 */
);
alter table bgafl_t add constraint bgafl_pk primary key (bgaflent,bgafl001,bgafl002,bgafl005) enable validate;

create unique index bgafl_pk on bgafl_t (bgaflent,bgafl001,bgafl002,bgafl005);

grant select on bgafl_t to tiptop;
grant update on bgafl_t to tiptop;
grant delete on bgafl_t to tiptop;
grant insert on bgafl_t to tiptop;

exit;
