/* 
================================================================================
檔案代號:gzzh_t
檔案名稱:TOPN資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzzh_t
(
gzzhent       number(5)      ,/* 企業代碼 */
gzzhownid       varchar2(20)      ,/* 資料所有者 */
gzzhowndp       varchar2(10)      ,/* 資料所屬部門 */
gzzhcrtid       varchar2(20)      ,/* 資料建立者 */
gzzhcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzzhcrtdt       timestamp(0)      ,/* 資料創建日 */
gzzhmodid       varchar2(20)      ,/* 資料修改者 */
gzzhmoddt       timestamp(0)      ,/* 最近修改日 */
gzzhstus       varchar2(10)      ,/* 狀態碼 */
gzzh001       varchar2(20)      ,/* 使用者編號 */
gzzh002       number(15,3)      ,/* 執行次數 */
gzzh003       varchar2(80)      ,/* 作業編號 */
gzzh004       number(10,0)      ,/* 執行花費時間(秒) */
gzzh005       timestamp(0)      /* 執行日期 */
);
alter table gzzh_t add constraint gzzh_pk primary key (gzzhent,gzzh001,gzzh003,gzzh005) enable validate;

create unique index gzzh_pk on gzzh_t (gzzhent,gzzh001,gzzh003,gzzh005);

grant select on gzzh_t to tiptop;
grant update on gzzh_t to tiptop;
grant delete on gzzh_t to tiptop;
grant insert on gzzh_t to tiptop;

exit;
