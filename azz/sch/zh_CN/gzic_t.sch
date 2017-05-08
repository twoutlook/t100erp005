/* 
================================================================================
檔案代號:gzic_t
檔案名稱:自定義查詢-彙總計算明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzic_t
(
gzic001       varchar2(20)      ,/* 查詢單ID */
gzic002       number(5,0)      ,/* 序號 */
gzic003       varchar2(1)      ,/* 計算式 */
gzic004       varchar2(1)      ,/* 依群組欄位 */
gzic005       number(5,0)      ,/* 群組欄位序號 */
gzic006       varchar2(255)      ,/* 備註 */
gzic007       varchar2(1)      /* 顯示方式 */
);
alter table gzic_t add constraint gzic_pk primary key (gzic001,gzic002,gzic005) enable validate;

create unique index gzic_pk on gzic_t (gzic001,gzic002,gzic005);

grant select on gzic_t to tiptop;
grant update on gzic_t to tiptop;
grant delete on gzic_t to tiptop;
grant insert on gzic_t to tiptop;

exit;
