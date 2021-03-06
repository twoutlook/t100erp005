/* 
================================================================================
檔案代號:dzcf_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzcf_t
(
dzcfstus       varchar2(10)      ,/* 狀態碼 */
dzcf001              ,/* DZCF001_MEMO */
dzcf002              ,/* DZCF002_MEMO */
dzcf003              ,/* DZCF003_MEMO */
dzcf004              ,/* DZCF004_MEMO */
dzcf005              ,/* DZCF005_MEMO */
dzcf006              ,/* DZCF006_MEMO */
dzcfownid       varchar2(10)      ,/* 資料所有者 */
dzcfowndp       varchar2(10)      ,/* 資料所屬部門 */
dzcfcrtid       varchar2(10)      ,/* 資料建立者 */
dzcfcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzcfcrtdt       date      ,/* 資料創建日 */
dzcfmodid       varchar2(10)      ,/* 資料修改者 */
dzcfmoddt       date      ,/* 最近修改日 */
dzcfcnfid       varchar2(10)      ,/* 資料確認者 */
dzcfcnfdt       date      /* 資料確認日 */
);
alter table dzcf_t add constraint dzcf_pk primary key (dzcf001,dzcf002) enable validate;


grant select on dzcf_t to tiptop;
grant update on dzcf_t to tiptop;
grant delete on dzcf_t to tiptop;
grant insert on dzcf_t to tiptop;

exit;
