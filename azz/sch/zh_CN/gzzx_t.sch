/* 
================================================================================
檔案代號:gzzx_t
檔案名稱:程式開發紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzzx_t
(
gzzx001       varchar2(20)      ,/* 程式編號 */
gzzx002       number(10)      ,/* 最後產出規格版次 */
gzzx003       varchar2(20)      ,/* 應用UI樣板類型 */
gzzx004       varchar2(20)      ,/* 應用程式樣板 */
gzzx005       date      ,/* tab最後異動時間 */
gzzx006       number(10,0)      ,/* 異動次數 */
gzzx007       varchar2(1)      ,/* 建置種類 */
gzzx008       varchar2(1)      ,/* 連結狀況 */
gzzx009       varchar2(1)      ,/* 編譯狀況 */
gzzx010       number(10)      ,/* 最後產出程式版次 */
gzzx011       varchar2(20)      ,/* 應用樣板(離手版本) */
gzzx012       number(10)      ,/* 應用樣板版本(離手版本) */
gzzx013       varchar2(80)      /* 程式MD5 */
);
alter table gzzx_t add constraint gzzx_pk primary key (gzzx001) enable validate;

create unique index gzzx_pk on gzzx_t (gzzx001);

grant select on gzzx_t to tiptop;
grant update on gzzx_t to tiptop;
grant delete on gzzx_t to tiptop;
grant insert on gzzx_t to tiptop;

exit;
