/* 
================================================================================
檔案代號:bgahs_t
檔案名稱:預算組織檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table bgahs_t
(
bgahsent       number(5)      ,/* 企業編號 */
bgahs001       varchar2(10)      ,/* 版本 */
bgahs004       varchar2(10)      ,/* 預算組織編號 */
bgahs005       varchar2(40)      ,/* 提速值 */
bgahs006       number(5,0)      /* 階層 */
);
alter table bgahs_t add constraint bgahs_pk primary key (bgahsent,bgahs001,bgahs004,bgahs005) enable validate;

create unique index bgahs_pk on bgahs_t (bgahsent,bgahs001,bgahs004,bgahs005);

grant select on bgahs_t to tiptop;
grant update on bgahs_t to tiptop;
grant delete on bgahs_t to tiptop;
grant insert on bgahs_t to tiptop;

exit;
