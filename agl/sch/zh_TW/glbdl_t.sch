/* 
================================================================================
檔案代號:glbdl_t
檔案名稱:間接法群組資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table glbdl_t
(
glbdlent       number(5)      ,/* 企業編號 */
glbdl001       varchar2(10)      ,/* 群組編號 */
glbdl002       varchar2(6)      ,/* 語言別 */
glbdl003       varchar2(500)      ,/* 說明 */
glbdl004       varchar2(10)      /* 助記碼 */
);
alter table glbdl_t add constraint glbdl_pk primary key (glbdlent,glbdl001,glbdl002) enable validate;

create unique index glbdl_pk on glbdl_t (glbdlent,glbdl001,glbdl002);

grant select on glbdl_t to tiptop;
grant update on glbdl_t to tiptop;
grant delete on glbdl_t to tiptop;
grant insert on glbdl_t to tiptop;

exit;
