/* 
================================================================================
檔案代號:dzfa_t
檔案名稱:畫面UI元件失效檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfa_t
(
dzfa001       varchar2(20)      ,/* 結構代號 */
dzfa002       varchar2(40)      ,/* 失效UI代碼 */
dzfa003       varchar2(1)      ,/* 客製 */
dzfa004       varchar2(40)      ,/* 客戶代號 */
dzfa005       varchar2(1)      ,/* UI元件類型 */
dzfa006       number(10)      ,/* 失效版次 */
dzfa007       varchar2(40)      ,/* 失效項目name */
dzfaownid       varchar2(20)      ,/* 資料所有者 */
dzfaowndp       varchar2(10)      ,/* 資料所屬部門 */
dzfacrtid       varchar2(20)      ,/* 資料建立者 */
dzfacrtdp       varchar2(10)      ,/* 資料建立部門 */
dzfacrtdt       timestamp(0)      ,/* 資料創建日 */
dzfamodid       varchar2(20)      ,/* 資料修改者 */
dzfamoddt       timestamp(0)      /* 最近修改日 */
);
alter table dzfa_t add constraint dzfa_pk primary key (dzfa001,dzfa002,dzfa003,dzfa007) enable validate;

create unique index dzfa_pk on dzfa_t (dzfa001,dzfa002,dzfa003,dzfa007);

grant select on dzfa_t to tiptop;
grant update on dzfa_t to tiptop;
grant delete on dzfa_t to tiptop;
grant insert on dzfa_t to tiptop;

exit;
