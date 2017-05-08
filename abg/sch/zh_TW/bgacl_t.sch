/* 
================================================================================
檔案代號:bgacl_t
檔案名稱:預算週期資料檔案多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bgacl_t
(
bgaclent       number(5)      ,/* 企業編號 */
bgacl001       varchar2(5)      ,/* 預算週期編號 */
bgacl002       varchar2(6)      ,/* 語言別 */
bgacl003       varchar2(500)      ,/* 說明 */
bgacl004       varchar2(10)      /* 助記碼 */
);
alter table bgacl_t add constraint bgacl_pk primary key (bgaclent,bgacl001,bgacl002) enable validate;

create unique index bgacl_pk on bgacl_t (bgaclent,bgacl001,bgacl002);

grant select on bgacl_t to tiptop;
grant update on bgacl_t to tiptop;
grant delete on bgacl_t to tiptop;
grant insert on bgacl_t to tiptop;

exit;
