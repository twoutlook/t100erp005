/* 
================================================================================
檔案代號:gzdh_t
檔案名稱:刪除後必須管制不可再新增紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzdh_t
(
gzdhownid       varchar2(20)      ,/* 資料所有者 */
gzdhowndp       varchar2(10)      ,/* 資料所屬部門 */
gzdhcrtid       varchar2(20)      ,/* 資料建立者 */
gzdhcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzdhcrtdt       timestamp(0)      ,/* 資料創建日 */
gzdhmodid       varchar2(20)      ,/* 資料修改者 */
gzdhmoddt       timestamp(0)      ,/* 最近修改日 */
gzdhstus       varchar2(10)      ,/* 狀態碼 */
gzdh001       varchar2(20)      ,/* 作業編號 */
gzdh002       varchar2(500)      /* 單據組合Key */
);
alter table gzdh_t add constraint gzdh_pk primary key (gzdh001,gzdh002) enable validate;

create unique index gzdh_pk on gzdh_t (gzdh001,gzdh002);

grant select on gzdh_t to tiptop;
grant update on gzdh_t to tiptop;
grant delete on gzdh_t to tiptop;
grant insert on gzdh_t to tiptop;

exit;
