/* 
================================================================================
檔案代號:dzlm_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzlm_t
(
dzlmstus       varchar2(10)      ,/* 狀態碼 */
dzlm001       varchar2(10)      ,/* 建構類型 */
dzlm002       varchar2(20)      ,/* 建構代號 */
dzlm003       varchar2(255)      ,/* 建構名稱 */
dzlm004       varchar2(10)      ,/* 模組 */
dzlm005       varchar2(10)      ,/* 建構版本 */
dzlm006       varchar2(10)      ,/* SD版本 */
dzlm007       varchar2(20)      ,/* SD帳號 */
dzlm008       varchar2(1)      ,/* SD權限 */
dzlm009       varchar2(10)      ,/* PR版本 */
dzlm010       varchar2(20)      ,/* PR帳號 */
dzlm011       varchar2(1)      ,/* PR權限 */
dzlmownid       varchar2(10)      ,/* 資料所有者 */
dzlmowndp       varchar2(10)      ,/* 資料所屬部門 */
dzlmcrtid       varchar2(10)      ,/* 資料建立者 */
dzlmcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzlmcrtdt       date      ,/* 資料創建日 */
dzlmmodid       varchar2(10)      ,/* 資料修改者 */
dzlmmoddt       date      ,/* 最近修改日 */
dzlmcnfid       varchar2(10)      ,/* 資料確認者 */
dzlmcnfdt       date      ,/* 資料確認日 */
dzlm012       varchar2(10)      /* 狀態 */
);
alter table dzlm_t add constraint dzlm_pk primary key (dzlm001,dzlm002,dzlm005) enable validate;


grant select on dzlm_t to tiptop;
grant update on dzlm_t to tiptop;
grant delete on dzlm_t to tiptop;
grant insert on dzlm_t to tiptop;

exit;
