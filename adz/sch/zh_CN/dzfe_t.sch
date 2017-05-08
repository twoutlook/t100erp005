/* 
================================================================================
檔案代號:dzfe_t
檔案名稱:畫面樣版架構額外附屬設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfe_t
(
dzfestus       varchar2(10)      ,/* 狀態碼 */
dzfe001       varchar2(20)      ,/* 畫面樣版類型 */
dzfe002       varchar2(10)      ,/* 使用的節點類型 */
dzfe003       number(5,0)      ,/* 順序 */
dzfe004       varchar2(20)      ,/* 類別 */
dzfe005       number(5,0)      ,/* 數量上限 */
dzfe006       varchar2(1)      ,/* 是否需要設定條件 */
dzfeownid       varchar2(20)      ,/* 資料所有者 */
dzfeowndp       varchar2(10)      ,/* 資料所屬部門 */
dzfecrtid       varchar2(20)      ,/* 資料建立者 */
dzfecrtdp       varchar2(10)      ,/* 資料建立部門 */
dzfecrtdt       timestamp(0)      ,/* 資料創建日 */
dzfemodid       varchar2(20)      ,/* 資料修改者 */
dzfemoddt       timestamp(0)      ,/* 最近修改日 */
dzfecnfid       varchar2(20)      ,/* 資料確認者 */
dzfecnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzfe_t add constraint dzfe_pk primary key (dzfe001,dzfe002,dzfe004) enable validate;

create unique index dzfe_pk on dzfe_t (dzfe001,dzfe002,dzfe004);

grant select on dzfe_t to tiptop;
grant update on dzfe_t to tiptop;
grant delete on dzfe_t to tiptop;
grant insert on dzfe_t to tiptop;

exit;
