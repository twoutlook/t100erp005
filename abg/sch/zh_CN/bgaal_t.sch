/* 
================================================================================
檔案代號:bgaal_t
檔案名稱:預算編號多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table bgaal_t
(
bgaalent       number(5)      ,/* 企業編號 */
bgaal001       varchar2(10)      ,/* 預算編號 */
bgaal002       varchar2(6)      ,/* 語言別 */
bgaal003       varchar2(500)      ,/* 說明 */
bgaal004       varchar2(10)      /* 助記碼 */
);
alter table bgaal_t add constraint bgaal_pk primary key (bgaalent,bgaal001,bgaal002) enable validate;

create unique index bgaal_pk on bgaal_t (bgaalent,bgaal001,bgaal002);

grant select on bgaal_t to tiptop;
grant update on bgaal_t to tiptop;
grant delete on bgaal_t to tiptop;
grant insert on bgaal_t to tiptop;

exit;
