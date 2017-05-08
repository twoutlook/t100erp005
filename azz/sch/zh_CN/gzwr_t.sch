/* 
================================================================================
檔案代號:gzwr_t
檔案名稱:作業操作說明檔案總管
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzwr_t
(
gzwrownid       varchar2(20)      ,/* 資料所有者 */
gzwrowndp       varchar2(10)      ,/* 資料所屬部門 */
gzwrcrtid       varchar2(20)      ,/* 資料建立者 */
gzwrcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzwrcrtdt       timestamp(0)      ,/* 資料創建日 */
gzwrmodid       varchar2(20)      ,/* 資料修改者 */
gzwrmoddt       timestamp(0)      ,/* 最近修改日 */
gzwrstus       varchar2(10)      ,/* 狀態碼 */
gzwr001       varchar2(20)      ,/* 作業編號 */
gzwr002       varchar2(1)      ,/* 客製 */
gzwr003       varchar2(6)      ,/* 語言別 */
gzwr004       varchar2(40)      ,/* 檔案編號 */
gzwr005       varchar2(1)      ,/* no use */
gzwr006       varchar2(255)      ,/* 檔名 */
gzwr007       varchar2(10)      ,/* 副檔名 */
gzwr008       varchar2(40)      /* 說明 */
);
alter table gzwr_t add constraint gzwr_pk primary key (gzwr001,gzwr002,gzwr003,gzwr004) enable validate;

create unique index gzwr_pk on gzwr_t (gzwr001,gzwr002,gzwr003,gzwr004);

grant select on gzwr_t to tiptop;
grant update on gzwr_t to tiptop;
grant delete on gzwr_t to tiptop;
grant insert on gzwr_t to tiptop;

exit;
