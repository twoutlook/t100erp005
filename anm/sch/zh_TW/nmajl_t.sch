/* 
================================================================================
檔案代號:nmajl_t
檔案名稱:銀行存提碼表資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table nmajl_t
(
nmajlent       number(5)      ,/* 企業編號 */
nmajl001       varchar2(10)      ,/* 銀行存提編碼 */
nmajl002       varchar2(6)      ,/* 語言別 */
nmajl003       varchar2(500)      ,/* 說明 */
nmajl004       varchar2(10)      /* 助記碼 */
);
alter table nmajl_t add constraint nmajl_pk primary key (nmajlent,nmajl001,nmajl002) enable validate;

create unique index nmajl_pk on nmajl_t (nmajlent,nmajl001,nmajl002);

grant select on nmajl_t to tiptop;
grant update on nmajl_t to tiptop;
grant delete on nmajl_t to tiptop;
grant insert on nmajl_t to tiptop;

exit;
