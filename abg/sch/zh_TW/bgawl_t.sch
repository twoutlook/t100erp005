/* 
================================================================================
檔案代號:bgawl_t
檔案名稱:預算樣表設置檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bgawl_t
(
bgawlent       number(5)      ,/* 企業編號 */
bgawl001       varchar2(10)      ,/* 樣表編號 */
bgawl002       varchar2(6)      ,/* 語言別 */
bgawl003       varchar2(500)      ,/* 說明 */
bgawl004       varchar2(10)      /* 助記碼 */
);
alter table bgawl_t add constraint bgawl_pk primary key (bgawlent,bgawl001,bgawl002) enable validate;

create unique index bgawl_pk on bgawl_t (bgawlent,bgawl001,bgawl002);

grant select on bgawl_t to tiptop;
grant update on bgawl_t to tiptop;
grant delete on bgawl_t to tiptop;
grant insert on bgawl_t to tiptop;

exit;
