/* 
================================================================================
檔案代號:dzek_t
檔案名稱:欄位類別定義明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzek_t
(
dzek001       varchar2(80)      ,/* 欄位類別定義代號 */
dzek002       varchar2(80)      ,/* 欄位代號 */
dzek003       varchar2(1)      ,/* 是否為主鍵 */
dzek004       varchar2(10)      ,/* 欄位屬性 */
dzek005       varchar2(80)      ,/* 欄位名稱 */
dzek006       number(10,0)      ,/* 序號 */
dzek007       varchar2(80)      ,/* 序號格式 */
dzek008       varchar2(1)      ,/* 是否啟動 */
dzek009       varchar2(1)      ,/* 必要欄位 */
dzek010       varchar2(80)      ,/* 不可刪除此欄位 */
dzek011       varchar2(1)      ,/* 是否為共用欄位 */
dzekownid       varchar2(20)      ,/* 資料所有者 */
dzekowndp       varchar2(10)      ,/* 資料所屬部門 */
dzekcrtid       varchar2(20)      ,/* 資料建立者 */
dzekcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzekcrtdt       timestamp(0)      ,/* 資料創建日 */
dzekmodid       varchar2(20)      ,/* 資料修改者 */
dzekmoddt       timestamp(0)      ,/* 最近修改日 */
dzekcnfid       varchar2(20)      ,/* 資料確認者 */
dzekcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzek_t add constraint dzek_pk primary key (dzek001,dzek002) enable validate;

create unique index dzek_pk on dzek_t (dzek001,dzek002);

grant select on dzek_t to tiptop;
grant update on dzek_t to tiptop;
grant delete on dzek_t to tiptop;
grant insert on dzek_t to tiptop;

exit;
