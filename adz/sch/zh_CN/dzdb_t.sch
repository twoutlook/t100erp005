/* 
================================================================================
檔案代號:dzdb_t
檔案名稱:元件參數檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzdb_t
(
dzdbstus       varchar2(10)      ,/* 狀態碼 */
dzdb001       varchar2(40)      ,/* 元件編號 */
dzdb002       varchar2(1)      ,/* 傳入/傳出flag */
dzdb003       number(10,0)      ,/* 順序 */
dzdb004       varchar2(500)      ,/* no use */
dzdb005       varchar2(40)      ,/* 參數 */
dzdb006       number(10)      ,/* 識別碼版次 */
dzdb007       varchar2(60)      ,/* 參數類型 */
dzdbownid       varchar2(20)      ,/* 資料所有者 */
dzdbowndp       varchar2(10)      ,/* 資料所屬部門 */
dzdbcrtid       varchar2(20)      ,/* 資料建立者 */
dzdbcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzdbcrtdt       timestamp(0)      ,/* 資料創建日 */
dzdbmodid       varchar2(20)      ,/* 資料修改者 */
dzdbmoddt       timestamp(0)      ,/* 最近修改日 */
dzdbcnfid       varchar2(20)      ,/* 資料確認者 */
dzdbcnfdt       timestamp(0)      ,/* 資料確認日 */
dzdb008       varchar2(1)      ,/* 使用標示 */
dzdb009       varchar2(40)      /* 客戶編號 */
);
alter table dzdb_t add constraint dzdb_pk primary key (dzdb001,dzdb002,dzdb003,dzdb006,dzdb008) enable validate;

create unique index dzdb_pk on dzdb_t (dzdb001,dzdb002,dzdb003,dzdb006,dzdb008);

grant select on dzdb_t to tiptop;
grant update on dzdb_t to tiptop;
grant delete on dzdb_t to tiptop;
grant insert on dzdb_t to tiptop;

exit;
