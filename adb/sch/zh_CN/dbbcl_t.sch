/* 
================================================================================
檔案代號:dbbcl_t
檔案名稱:銷售範圍基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dbbcl_t
(
dbbclent       number(5)      ,/* 企業編號 */
dbbcl001       varchar2(10)      ,/* 銷售範圍編號 */
dbbcl002       varchar2(6)      ,/* 語言別 */
dbbcl003       varchar2(500)      ,/* 說明 */
dbbcl004       varchar2(10)      /* 助記碼 */
);
alter table dbbcl_t add constraint dbbcl_pk primary key (dbbclent,dbbcl001,dbbcl002) enable validate;

create unique index dbbcl_pk on dbbcl_t (dbbclent,dbbcl001,dbbcl002);

grant select on dbbcl_t to tiptop;
grant update on dbbcl_t to tiptop;
grant delete on dbbcl_t to tiptop;
grant insert on dbbcl_t to tiptop;

exit;
