/* 
================================================================================
檔案代號:dzda_t
檔案名稱:元件基本檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzda_t
(
dzdastus       varchar2(10)      ,/* 狀態碼 */
dzda001       varchar2(40)      ,/* 元件編號 */
dzda002       varchar2(15)      ,/* no use */
dzda003       varchar2(20)      ,/* 4gl編號 */
dzda004       varchar2(255)      ,/* no use */
dzda005       varchar2(1)      ,/* 資料庫 */
dzda006       varchar2(10)      ,/* 所屬模組 */
dzda007       varchar2(80)      ,/*  no use */
dzda008       varchar2(80)      ,/* no use */
dzda009       varchar2(40)      ,/* 客戶編號 */
dzda010       varchar2(1)      ,/* 資料庫資料異動否 */
dzdaownid       varchar2(20)      ,/* 資料所有者 */
dzdaowndp       varchar2(10)      ,/* 資料所屬部門 */
dzdacrtid       varchar2(20)      ,/* 資料建立者 */
dzdacrtdp       varchar2(10)      ,/* 資料建立部門 */
dzdacrtdt       timestamp(0)      ,/* 資料創建日 */
dzdamodid       varchar2(20)      ,/* 資料修改者 */
dzdamoddt       timestamp(0)      ,/* 最近修改日 */
dzdacnfid       varchar2(20)      ,/* 資料確認者 */
dzdacnfdt       timestamp(0)      ,/* 資料確認日 */
dzda011       varchar2(1)      ,/* 資料庫結構異動否 */
dzda012       varchar2(4000)      /* 備註 */
);
alter table dzda_t add constraint dzda_pk primary key (dzda001) enable validate;

create unique index dzda_pk on dzda_t (dzda001);

grant select on dzda_t to tiptop;
grant update on dzda_t to tiptop;
grant delete on dzda_t to tiptop;
grant insert on dzda_t to tiptop;

exit;
