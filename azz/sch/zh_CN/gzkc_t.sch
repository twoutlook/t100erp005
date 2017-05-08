/* 
================================================================================
檔案代號:gzkc_t
檔案名稱:訊息內容
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzkc_t
(
gzkc001       varchar2(20)      ,/* 作業編號 */
gzkc002       varchar2(80)      ,/* 功能選項 */
gzkc003       varchar2(80)      ,/* 訊息發送主旨 */
gzkc004       varchar2(4000)      ,/* 訊息發送内容 */
gzkc005       varchar2(1)      ,/* 通知條件 */
gzkc006       varchar2(10)      ,/* 條件內容 */
gzkc007       varchar2(80)      ,/* 訊息發送主旨 */
gzkc008       varchar2(4000)      ,/* 訊息發送內容 */
gzkc009       varchar2(1)      ,/* 設定類別 */
gzkcent       number(5)      /* 企業代碼 */
);
alter table gzkc_t add constraint gzkc_pk primary key (gzkc001,gzkc002,gzkc005,gzkc006,gzkc009,gzkcent) enable validate;

create unique index gzkc_pk on gzkc_t (gzkc001,gzkc002,gzkc005,gzkc006,gzkc009,gzkcent);

grant select on gzkc_t to tiptop;
grant update on gzkc_t to tiptop;
grant delete on gzkc_t to tiptop;
grant insert on gzkc_t to tiptop;

exit;
