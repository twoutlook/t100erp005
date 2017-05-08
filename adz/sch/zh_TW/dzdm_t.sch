/* 
================================================================================
檔案代號:dzdm_t
檔案名稱:記錄應用元件規格設計文檔中的測試記錄
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzdm_t
(
dzdmownid       varchar2(20)      ,/* 資料所有者 */
dzdmowndp       varchar2(10)      ,/* 資料所屬部門 */
dzdmcrtid       varchar2(20)      ,/* 資料建立者 */
dzdmcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzdmcrtdt       timestamp(0)      ,/* 資料創建日 */
dzdmmodid       varchar2(20)      ,/* 資料修改者 */
dzdmmoddt       timestamp(0)      ,/* 最近修改日 */
dzdmcnfid       varchar2(20)      ,/* 資料確認者 */
dzdmcnfdt       timestamp(0)      ,/* 資料確認日 */
dzdm001       varchar2(40)      ,/* 元件代號 */
dzdm002       number(10,0)      ,/* 項次 */
dzdm003       varchar2(500)      ,/* 情景說明 */
dzdm004       varchar2(500)      ,/* 傳入值 */
dzdm005       varchar2(500)      ,/* 預計傳出值 */
dzdm006       varchar2(1)      ,/* 正向負向檢查 */
dzdm007       varchar2(10)      ,/* 輸出的錯誤代號 */
dzdm008       varchar2(40)      ,/* 客戶代號 */
dzdm009       varchar2(4000)      ,/* 備註 */
dzdm010       number(10)      ,/* 識別碼版次 */
dzdm011       varchar2(1)      ,/* 使用標示 */
dzdmstus       varchar2(10)      /* 狀態碼 */
);
alter table dzdm_t add constraint dzdm_pk primary key (dzdm001,dzdm002,dzdm010,dzdm011) enable validate;

create unique index dzdm_pk on dzdm_t (dzdm001,dzdm002,dzdm010,dzdm011);

grant select on dzdm_t to tiptop;
grant update on dzdm_t to tiptop;
grant delete on dzdm_t to tiptop;
grant insert on dzdm_t to tiptop;

exit;
