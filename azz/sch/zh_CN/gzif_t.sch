/* 
================================================================================
檔案代號:gzif_t
檔案名稱:自定義查詢-自定義資料轉換設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzif_t
(
gzif001       varchar2(20)      ,/* 查詢單ID */
gzif002       number(5,0)      ,/* 序號 */
gzif003       varchar2(1)      ,/* 轉換項目 */
gzif004       varchar2(80)      ,/* 原轉換值 */
gzif005       varchar2(1)      ,/* 取代型態 */
gzif006       varchar2(80)      /* 取代值 */
);
alter table gzif_t add constraint gzif_pk primary key (gzif001,gzif002,gzif004) enable validate;

create unique index gzif_pk on gzif_t (gzif001,gzif002,gzif004);

grant select on gzif_t to tiptop;
grant update on gzif_t to tiptop;
grant delete on gzif_t to tiptop;
grant insert on gzif_t to tiptop;

exit;
