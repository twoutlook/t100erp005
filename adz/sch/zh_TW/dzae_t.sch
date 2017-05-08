/* 
================================================================================
檔案代號:dzae_t
檔案名稱:程式資料設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzae_t
(
dzaestus       varchar2(10)      ,/* 狀態碼 */
dzae001       varchar2(20)      ,/* 程式編號 */
dzae002       varchar2(15)      ,/* 程式版次 */
dzae003       varchar2(20)      ,/* No Use */
dzae004       varchar2(20)      ,/* UI版型 */
dzaeownid       varchar2(10)      ,/* 資料所有者 */
dzaeowndp       varchar2(10)      ,/* 資料所屬部門 */
dzaecrtid       varchar2(10)      ,/* 資料建立者 */
dzaecrtdp       varchar2(10)      ,/* 資料建立部門 */
dzaecrtdt       date      ,/* 資料創建日 */
dzaemodid       varchar2(10)      ,/* 資料修改者 */
dzaemoddt       date      /* 最近修改日 */
);
alter table dzae_t add constraint dzae_pk primary key (dzae001,dzae002) enable validate;


grant select on dzae_t to tiptop;
grant update on dzae_t to tiptop;
grant delete on dzae_t to tiptop;
grant insert on dzae_t to tiptop;

exit;
