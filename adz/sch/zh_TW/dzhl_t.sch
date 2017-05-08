/* 
================================================================================
檔案代號:dzhl_t
檔案名稱:資料庫物件異動紀錄
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzhl_t
(
dzhl001       number(10,0)      ,/* 紀錄序號 */
dzhl002       varchar2(20)      ,/* 等級 */
dzhl003       varchar2(20)      ,/* 類別 */
dzhl004       timestamp(0)      ,/* 紀錄時間 */
dzhl005       varchar2(4000)      ,/* 內容 */
dzhlcrtid       varchar2(20)      ,/* 資料建立者 */
dzhlcrtdt       timestamp(0)      ,/* 資料創建日 */
dzhlmodid       varchar2(20)      ,/* 資料修改者 */
dzhlmoddt       timestamp(0)      /* 最近修改日 */
);
alter table dzhl_t add constraint dzhl_pk primary key (dzhl001) enable validate;

create unique index dzhl_pk on dzhl_t (dzhl001);

grant select on dzhl_t to tiptop;
grant update on dzhl_t to tiptop;
grant delete on dzhl_t to tiptop;
grant insert on dzhl_t to tiptop;

exit;
