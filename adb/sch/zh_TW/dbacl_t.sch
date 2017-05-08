/* 
================================================================================
檔案代號:dbacl_t
檔案名稱:片區基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dbacl_t
(
dbaclent       number(5)      ,/* 企業編號 */
dbacl001       varchar2(10)      ,/* 片區編號 */
dbacl002       varchar2(6)      ,/* 語言別 */
dbacl003       varchar2(500)      ,/* 說明(簡稱) */
dbacl004       varchar2(500)      ,/* 說明(全稱) */
dbacl005       varchar2(10)      /* 助記碼 */
);
alter table dbacl_t add constraint dbacl_pk primary key (dbaclent,dbacl001,dbacl002) enable validate;

create unique index dbacl_pk on dbacl_t (dbaclent,dbacl001,dbacl002);

grant select on dbacl_t to tiptop;
grant update on dbacl_t to tiptop;
grant delete on dbacl_t to tiptop;
grant insert on dbacl_t to tiptop;

exit;
