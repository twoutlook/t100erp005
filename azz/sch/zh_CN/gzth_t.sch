/* 
================================================================================
檔案代號:gzth_t
檔案名稱:知識庫索引
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzth_t
(
gzthownid       varchar2(20)      ,/* 資料所有者 */
gzthowndp       varchar2(10)      ,/* 資料所屬部門 */
gzthcrtid       varchar2(20)      ,/* 資料建立者 */
gzthcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzthcrtdt       timestamp(0)      ,/* 資料創建日 */
gzthmodid       varchar2(20)      ,/* 資料修改者 */
gzthmoddt       timestamp(0)      ,/* 最近修改日 */
gzthstus       varchar2(10)      ,/* 狀態碼 */
gzth001       varchar2(10)      ,/* 索引編號 */
gzth002       varchar2(10)      ,/* 上層編號 */
gzth003       varchar2(1)      ,/* 客製 */
gzth004       varchar2(10)      ,/* 節點類型 */
gzth005       number(5,0)      ,/* 顯示順序 */
gzth006       varchar2(255)      ,/* 圖示 */
gzth007       varchar2(4)      /* 模組編號 */
);
alter table gzth_t add constraint gzth_pk primary key (gzth001,gzth002) enable validate;

create unique index gzth_pk on gzth_t (gzth001,gzth002);

grant select on gzth_t to tiptop;
grant update on gzth_t to tiptop;
grant delete on gzth_t to tiptop;
grant insert on gzth_t to tiptop;

exit;
