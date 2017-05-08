/* 
================================================================================
檔案代號:gzbb_t
檔案名稱:流程圖節點資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table gzbb_t
(
gzbbent       number(5)      ,/* 企業代碼 */
gzbb001       varchar2(40)      ,/* 節點代號 */
gzbb002       varchar2(40)      ,/* 分類代號 */
gzbb003       varchar2(10)      ,/* 節點類型 */
gzbb004       varchar2(255)      ,/* 節點資訊 */
gzbb005       varchar2(40)      ,/* 可用節點代號(gzbd001) */
gzbb006       varchar2(20)      /* 程式代號 */
);
alter table gzbb_t add constraint gzbb_pk primary key (gzbbent,gzbb001,gzbb002) enable validate;

create unique index gzbb_pk on gzbb_t (gzbbent,gzbb001,gzbb002);

grant select on gzbb_t to tiptop;
grant update on gzbb_t to tiptop;
grant delete on gzbb_t to tiptop;
grant insert on gzbb_t to tiptop;

exit;
