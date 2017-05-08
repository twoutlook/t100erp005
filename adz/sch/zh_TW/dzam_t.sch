/* 
================================================================================
檔案代號:dzam_t
檔案名稱:規格畫面元件排除設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzam_t
(
dzam001       varchar2(20)      ,/* 規格名稱 */
dzam002       varchar2(40)      ,/* patch標示 */
dzam003       varchar2(40)      ,/* 排除項目 */
dzamownid       varchar2(20)      ,/* 資料所有者 */
dzamowndp       varchar2(10)      ,/* 資料所屬部門 */
dzamcrtid       varchar2(20)      ,/* 資料建立者 */
dzamcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzamcrtdt       timestamp(0)      ,/* 資料創建日 */
dzammodid       varchar2(20)      ,/* 資料修改者 */
dzammoddt       timestamp(0)      ,/* 最近修改日 */
dzamstus       varchar2(10)      ,/* 狀態碼 */
dzam004       number(10)      ,/* 識別碼版次 */
dzam005       varchar2(1)      ,/* 使用標示 */
dzam006       varchar2(40)      /* 客戶代號 */
);
alter table dzam_t add constraint dzam_pk primary key (dzam001,dzam003,dzam004,dzam005) enable validate;

create unique index dzam_pk on dzam_t (dzam001,dzam003,dzam004,dzam005);

grant select on dzam_t to tiptop;
grant update on dzam_t to tiptop;
grant delete on dzam_t to tiptop;
grant insert on dzam_t to tiptop;

exit;
