/* 
================================================================================
檔案代號:dzfs_t
檔案名稱:程式Table與Screen Record對應檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfs_t
(
dzfsstus       varchar2(10)      ,/* 狀態碼 */
dzfs001       number(10)      ,/* 識別碼版號 */
dzfs002       varchar2(20)      ,/* 程式代號 */
dzfs003       varchar2(40)      ,/* Screen Record */
dzfs004       varchar2(15)      ,/* 資料表編號 */
dzfs005       varchar2(1)      ,/* 使用標示 */
dzfsownid       varchar2(20)      ,/* 資料所有者 */
dzfsowndp       varchar2(10)      ,/* 資料所屬部門 */
dzfscrtid       varchar2(20)      ,/* 資料建立者 */
dzfscrtdp       varchar2(10)      ,/* 資料建立部門 */
dzfscrtdt       timestamp(0)      ,/* 資料創建日 */
dzfsmodid       varchar2(20)      ,/* 資料修改者 */
dzfsmoddt       timestamp(0)      ,/* 最近修改日 */
dzfs006       varchar2(1)      ,/* 允許插入 */
dzfs007       varchar2(1)      ,/* 允許刪除 */
dzfs008       varchar2(1)      ,/* 允許新增 */
dzfs009       varchar2(1)      ,/* 是否連動 */
dzfs010       varchar2(20)      ,/* 種類 */
dzfs011       varchar2(40)      ,/* 客戶代號 */
dzfs012       varchar2(1)      /* patch標示 */
);
alter table dzfs_t add constraint dzfs_pk primary key (dzfs001,dzfs002,dzfs003,dzfs005) enable validate;

create unique index dzfs_pk on dzfs_t (dzfs001,dzfs002,dzfs003,dzfs005);

grant select on dzfs_t to tiptop;
grant update on dzfs_t to tiptop;
grant delete on dzfs_t to tiptop;
grant insert on dzfs_t to tiptop;

exit;
