/* 
================================================================================
檔案代號:dzcg_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzcg_t
(
dzcgstus       varchar2(10)      ,/* 狀態碼 */
dzcg001              ,/* DZCG001_MEMO */
dzcg002              ,/* DZCG002_MEMO */
dzcgownid       varchar2(10)      ,/* 資料所有者 */
dzcgowndp       varchar2(10)      ,/* 資料所屬部門 */
dzcgcrtid       varchar2(10)      ,/* 資料建立者 */
dzcgcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzcgcrtdt       date      ,/* 資料創建日 */
dzcgmodid       varchar2(10)      ,/* 資料修改者 */
dzcgmoddt       date      ,/* 最近修改日 */
dzcgcnfid       varchar2(10)      ,/* 資料確認者 */
dzcgcnfdt       date      /* 資料確認日 */
);
alter table dzcg_t add constraint dzcg_pk primary key (dzcg001,dzcg002) enable validate;


grant select on dzcg_t to tiptop;
grant update on dzcg_t to tiptop;
grant delete on dzcg_t to tiptop;
grant insert on dzcg_t to tiptop;

exit;
