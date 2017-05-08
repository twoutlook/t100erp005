/* 
================================================================================
檔案代號:xmaml_t
檔案名稱:包裝方式多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table xmaml_t
(
xmamlent       number(5)      ,/* 企業編號 */
xmaml001       varchar2(10)      ,/* 包裝方式 */
xmaml002       varchar2(6)      ,/* 語言 */
xmaml003       varchar2(500)      ,/* 包裝說明 */
xmaml004       varchar2(10)      /* 助記碼 */
);
alter table xmaml_t add constraint xmaml_pk primary key (xmamlent,xmaml001,xmaml002) enable validate;

create unique index xmaml_pk on xmaml_t (xmamlent,xmaml001,xmaml002);

grant select on xmaml_t to tiptop;
grant update on xmaml_t to tiptop;
grant delete on xmaml_t to tiptop;
grant insert on xmaml_t to tiptop;

exit;
