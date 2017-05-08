/* 
================================================================================
檔案代號:gzzg_t
檔案名稱:inc程式共用變數檔設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzzg_t
(
gzzgownid       varchar2(20)      ,/* 資料所有者 */
gzzgowndp       varchar2(10)      ,/* 資料所屬部門 */
gzzgcrtid       varchar2(20)      ,/* 資料建立者 */
gzzgcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzzgcrtdt       timestamp(0)      ,/* 資料創建日 */
gzzgmodid       varchar2(20)      ,/* 資料修改者 */
gzzgmoddt       timestamp(0)      ,/* 最近修改日 */
gzzgstus       varchar2(10)      ,/* 狀態碼 */
gzzg001       varchar2(20)      ,/* 變數檔編號 */
gzzg002       varchar2(4)      ,/* 歸屬模組 */
gzzg003       varchar2(80)      ,/* 歸屬行業 */
gzzg004       varchar2(1)      ,/* 客製 */
gzzg005       varchar2(4000)      ,/* 變數檔內容 */
gzzg006       clob      /* 變數檔內容 */
);
alter table gzzg_t add constraint gzzg_pk primary key (gzzg001) enable validate;

create unique index gzzg_pk on gzzg_t (gzzg001);

grant select on gzzg_t to tiptop;
grant update on gzzg_t to tiptop;
grant delete on gzzg_t to tiptop;
grant insert on gzzg_t to tiptop;

exit;
