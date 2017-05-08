/* 
================================================================================
檔案代號:gzzj_t
檔案名稱:模組編號明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzzj_t
(
gzzj001       varchar2(4)      ,/* 實際模組編號 */
gzzj002       varchar2(10)      ,/* 功能類別 */
gzzj003       varchar2(4)      ,/* 歸屬模組編號 */
gzzjownid       varchar2(20)      ,/* 資料所有者 */
gzzjowndp       varchar2(10)      ,/* 資料所屬部門 */
gzzjcrtid       varchar2(20)      ,/* 資料建立者 */
gzzjcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzzjcrtdt       timestamp(0)      ,/* 資料創建日 */
gzzjmodid       varchar2(20)      ,/* 資料修改者 */
gzzjmoddt       timestamp(0)      ,/* 最近修改日 */
gzzjstus       varchar2(10)      /* 狀態碼 */
);
alter table gzzj_t add constraint gzzj_pk primary key (gzzj001) enable validate;

create unique index gzzj_pk on gzzj_t (gzzj001);

grant select on gzzj_t to tiptop;
grant update on gzzj_t to tiptop;
grant delete on gzzj_t to tiptop;
grant insert on gzzj_t to tiptop;

exit;
