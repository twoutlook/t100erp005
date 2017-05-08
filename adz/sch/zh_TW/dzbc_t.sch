/* 
================================================================================
檔案代號:dzbc_t
檔案名稱:section標準資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzbc_t
(
dzbcstus       varchar2(10)      ,/* 狀態碼 */
dzbc001       varchar2(20)      ,/* 代碼編號 */
dzbc002       number(10)      ,/* 代碼版次 */
dzbc003       varchar2(60)      ,/* section編號 */
dzbc004       number(10)      ,/* section版次 */
dzbc005       varchar2(1)      ,/* 使用標示 */
dzbcownid       varchar2(20)      ,/* 資料所有者 */
dzbcowndp       varchar2(10)      ,/* 資料所屬部門 */
dzbccrtid       varchar2(20)      ,/* 資料建立者 */
dzbccrtdp       varchar2(10)      ,/* 資料建立部門 */
dzbccrtdt       timestamp(0)      ,/* 資料創建日 */
dzbcmodid       varchar2(20)      ,/* 資料修改者 */
dzbcmoddt       timestamp(0)      ,/* 最近修改日 */
dzbc006       varchar2(20)      ,/* 產品版本 */
dzbc007       varchar2(1)      ,/* 客製 */
dzbc008       varchar2(40)      ,/* 客戶代號 */
dzbc009       varchar2(1)      ,/* 本版次異動 */
dzbc010       varchar2(10)      ,/* section序號 */
dzbc011       varchar2(1)      /* ReadOnly */
);
alter table dzbc_t add constraint dzbc_pk primary key (dzbc001,dzbc002,dzbc003,dzbc007) enable validate;

create unique index dzbc_pk on dzbc_t (dzbc001,dzbc002,dzbc003,dzbc007);

grant select on dzbc_t to tiptop;
grant update on dzbc_t to tiptop;
grant delete on dzbc_t to tiptop;
grant insert on dzbc_t to tiptop;

exit;
