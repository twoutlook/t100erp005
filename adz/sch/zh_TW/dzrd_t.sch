/* 
================================================================================
檔案代號:dzrd_t
檔案名稱:GR報表樣板主檔(備份)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzrd_t
(
dzrdstus       varchar2(10)      ,/* 狀態碼 */
dzrd000       varchar2(80)      ,/* 報表樣板ID */
dzrd001       varchar2(20)      ,/* 報表元件代號 */
dzrd002       varchar2(20)      ,/* 樣板代號 */
dzrd003       varchar2(1)      ,/* 客製 */
dzrd004       varchar2(40)      ,/* 角色 */
dzrd005       varchar2(10)      ,/* 用戶 */
dzrd006       number(10,0)      ,/* 序號 */
dzrd007       varchar2(40)      ,/* 樣板名稱(4rp) */
dzrd008       varchar2(1)      ,/* 預設樣板 */
dzrd009       varchar2(1)      ,/* 列印簽核 */
dzrd010       varchar2(1)      ,/* 簽核位置 */
dzrd011       number(5,0)      ,/* 報表執行逾期時間(分) */
dzrd012       varchar2(1)      ,/* 中越樣板 */
dzrd013       varchar2(100)      ,/* 客戶紙張 */
dzrdownid       varchar2(20)      ,/* 資料所有者 */
dzrdowndp       varchar2(10)      ,/* 資料所屬部門 */
dzrdcrtid       varchar2(20)      ,/* 資料建立者 */
dzrdcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzrdcrtdt       timestamp(0)      ,/* 資料創建日 */
dzrdmodid       varchar2(20)      ,/* 資料修改者 */
dzrdmoddt       timestamp(0)      ,/* 最近修改日 */
dzrd014       varchar2(1)      /* 表頭位置 */
);
alter table dzrd_t add constraint dzrd_pk primary key (dzrd000) enable validate;

create unique index dzrd_pk on dzrd_t (dzrd000);
create unique index dzrd_u on dzrd_t (dzrd001,dzrd002,dzrd003,dzrd004,dzrd005,dzrd006);

grant select on dzrd_t to tiptop;
grant update on dzrd_t to tiptop;
grant delete on dzrd_t to tiptop;
grant insert on dzrd_t to tiptop;

exit;
