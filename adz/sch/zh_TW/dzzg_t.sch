/* 
================================================================================
檔案代號:dzzg_t
檔案名稱:簽核等級單頭(測試用)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzzg_t
(
dzzgstus       varchar2(10)      ,/* 狀態碼 */
dzzg001              ,/* 簽核等級 */
dzzg002       varchar2(80)      ,/* 說明 */
dzzg003       varchar2(80)      ,/* 說明 */
dzzg004       varchar2(10)      ,/* ComboBox(改屬性) */
dzzg005       varchar2(10)      ,/* ButtonEdit欄位(改屬性) */
dzzg006       date      ,/* 日期欄位(改屬性) */
dzzg007       varchar2(1)      ,/* 是否需查看後方可簽核 */
dzzg008       varchar2(1)      ,/* 是否由系統自動賦予簽核等級 */
dzzg009       varchar2(10)      ,/* 簽核單據別 */
dzzg010       varchar2(80)      ,/* 賦予條件 */
dzzg011       varchar2(10)      ,/* 換為人員代號 */
dzzgownid       varchar2(10)      ,/* 資料所有者 */
dzzgowndp       varchar2(10)      ,/* 資料所屬部門 */
dzzgcrtid       varchar2(10)      ,/* 資料建立者 */
dzzgcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzzgcrtdt       date      ,/* 資料創建日 */
dzzgmodid       varchar2(10)      ,/* 資料修改者 */
dzzgmoddt       date      ,/* 最近修改日 */
dzzgcnfid       varchar2(10)      ,/* 資料確認者 */
dzzgcnfdt       date      /* 資料確認日 */
);
alter table dzzg_t add constraint dzzg_pk primary key (dzzg001) enable validate;


grant select on dzzg_t to tiptop;
grant update on dzzg_t to tiptop;
grant delete on dzzg_t to tiptop;
grant insert on dzzg_t to tiptop;

exit;
