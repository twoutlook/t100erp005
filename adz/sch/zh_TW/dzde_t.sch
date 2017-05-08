/* 
================================================================================
檔案代號:dzde_t
檔案名稱:元件4gl清單檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzde_t
(
dzdestus       varchar2(10)      ,/* 狀態碼 */
dzde001       varchar2(20)      ,/* 4gl代號 */
dzde002       varchar2(6)      ,/* 語言別 */
dzde003       varchar2(255)      ,/* 程式說明 */
dzde004       varchar2(4)      ,/* 所屬模組 */
dzde005       varchar2(1)      ,/* 有畫面否 */
dzdeownid       varchar2(20)      ,/* 資料所有者 */
dzdeowndp       varchar2(10)      ,/* 資料所屬部門 */
dzdecrtid       varchar2(20)      ,/* 資料建立者 */
dzdecrtdp       varchar2(10)      ,/* 資料建立部門 */
dzdecrtdt       timestamp(0)      ,/* 資料創建日 */
dzdemodid       varchar2(20)      ,/* 資料修改者 */
dzdemoddt       timestamp(0)      ,/* 最近修改日 */
dzdecnfid       varchar2(20)      ,/* 資料確認者 */
dzdecnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzde_t add constraint dzde_pk primary key (dzde001,dzde002) enable validate;

create unique index dzde_pk on dzde_t (dzde001,dzde002);

grant select on dzde_t to tiptop;
grant update on dzde_t to tiptop;
grant delete on dzde_t to tiptop;
grant insert on dzde_t to tiptop;

exit;
