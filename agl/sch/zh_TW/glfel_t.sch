/* 
================================================================================
檔案代號:glfel_t
檔案名稱:財務指標公式設定維護單身檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table glfel_t
(
glfelent       number(5)      ,/* 企業編號 */
glfel001       varchar2(10)      ,/* 指標編號 */
glfelseq       number(10,0)      ,/* 項次 */
glfel002       varchar2(6)      ,/* 語言別 */
glfel003       varchar2(500)      ,/* 指標名稱 */
glfel004       varchar2(500)      ,/* 指標釋義 */
glfel005       varchar2(10)      /* 助記碼 */
);
alter table glfel_t add constraint glfel_pk primary key (glfelent,glfel001,glfelseq,glfel002) enable validate;

create unique index glfel_pk on glfel_t (glfelent,glfel001,glfelseq,glfel002);

grant select on glfel_t to tiptop;
grant update on glfel_t to tiptop;
grant delete on glfel_t to tiptop;
grant insert on glfel_t to tiptop;

exit;
