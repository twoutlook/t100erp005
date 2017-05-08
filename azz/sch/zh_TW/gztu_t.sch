/* 
================================================================================
檔案代號:gztu_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gztu_t
(
gztumodu       varchar2(10)      ,/* 資料修改者 */
gztudate       date      ,/* 最近修改日 */
gztuoriu       varchar2(10)      ,/* 資料所有者 */
gztuorid       varchar2(10)      ,/* 資料所有部門 */
gztuuser       varchar2(10)      ,/* 資料建立者 */
gztudept       varchar2(10)      ,/* 資料建立部門 */
gztubuid       date      ,/* 資料創建日 */
gztu001       varchar2(20)      ,/* 欄位編號 */
gztu002       number(5)      ,/* 語言別 */
gztu003       varchar2(80)      ,/* 欄位名稱 */
gztu004       varchar2(80)      /* 欄位說明 */
);
alter table gztu_t add constraint gztu_pk primary key (gztu001,gztu002) enable validate;


grant select on gztu_t to tiptop;
grant update on gztu_t to tiptop;
grant delete on gztu_t to tiptop;
grant insert on gztu_t to tiptop;

exit;
