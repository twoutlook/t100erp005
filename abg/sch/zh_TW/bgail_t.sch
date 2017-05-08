/* 
================================================================================
檔案代號:bgail_t
檔案名稱:預算管理組織多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table bgail_t
(
bgailent       number(5)      ,/* 企業編號 */
bgail001       varchar2(10)      ,/* 預算編號 */
bgail002       varchar2(10)      ,/* 預算管理組織 */
bgail003       varchar2(6)      ,/* 語言別 */
bgail004       varchar2(500)      ,/* 說明 */
bgail005       varchar2(10)      /* 助記碼 */
);
alter table bgail_t add constraint bgail_pk primary key (bgailent,bgail001,bgail002,bgail003) enable validate;

create unique index bgail_pk on bgail_t (bgailent,bgail001,bgail002,bgail003);

grant select on bgail_t to tiptop;
grant update on bgail_t to tiptop;
grant delete on bgail_t to tiptop;
grant insert on bgail_t to tiptop;

exit;
