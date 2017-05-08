/* 
================================================================================
檔案代號:oocul_t
檔案名稱:材積重設定檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table oocul_t
(
ooculent       number(5)      ,/* 企業編號 */
oocul001       varchar2(10)      ,/* 材積編號 */
oocul002       varchar2(6)      ,/* 語言別 */
oocul003       varchar2(500)      ,/* 材積名稱 */
oocul004       varchar2(10)      ,/* 助記碼 */
oocul005       varchar2(500)      /* 材積說明 */
);
alter table oocul_t add constraint oocul_pk primary key (ooculent,oocul001,oocul002) enable validate;

create unique index oocul_pk on oocul_t (ooculent,oocul001,oocul002);

grant select on oocul_t to tiptop;
grant update on oocul_t to tiptop;
grant delete on oocul_t to tiptop;
grant insert on oocul_t to tiptop;

exit;
