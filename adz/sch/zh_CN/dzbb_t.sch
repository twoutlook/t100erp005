/* 
================================================================================
檔案代號:dzbb_t
檔案名稱:代碼設計點設計表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzbb_t
(
dzbbstus       varchar2(10)      ,/* no use */
dzbb001       varchar2(20)      ,/* 代碼編號 */
dzbb002       varchar2(60)      ,/* 代碼設計點 */
dzbb003       number(10)      ,/* 設計點版次 */
dzbb004       varchar2(1)      ,/* 使用標示 */
dzbb098       clob      ,/* 設計點內容 */
dzbb005       varchar2(40)      ,/* 客戶代號 */
dzbb006       varchar2(15)      ,/* 設計點標記 */
dzbbownid       varchar2(20)      ,/* 資料所有者 */
dzbbowndp       varchar2(10)      ,/* 資料所屬部門 */
dzbbcrtid       varchar2(20)      ,/* 資料建立者 */
dzbbcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzbbcrtdt       timestamp(0)      ,/* 資料創建日 */
dzbbmodid       varchar2(20)      ,/* 資料修改者 */
dzbbmoddt       timestamp(0)      ,/* 最近修改日 */
dzbb007       varchar2(1)      /* no use */
);
alter table dzbb_t add constraint dzbb_pk primary key (dzbb001,dzbb002,dzbb003,dzbb004) enable validate;

create unique index dzbb_pk on dzbb_t (dzbb001,dzbb002,dzbb003,dzbb004);

grant select on dzbb_t to tiptop;
grant update on dzbb_t to tiptop;
grant delete on dzbb_t to tiptop;
grant insert on dzbb_t to tiptop;

exit;
