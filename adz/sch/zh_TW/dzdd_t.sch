/* 
================================================================================
檔案代號:dzdd_t
檔案名稱:元件前置/後置檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzdd_t
(
dzddstus       varchar2(10)      ,/* 狀態碼 */
dzdd001       varchar2(40)      ,/* 元件代號 */
dzdd002       number(10,0)      ,/* 序號 */
dzdd003       number(10)      ,/* 識別碼版次 */
dzdd004       varchar2(40)      ,/* 前置/後置元件 */
dzdd005       varchar2(1)      ,/* 使用標示 */
dzddownid       varchar2(20)      ,/* 資料所有者 */
dzddowndp       varchar2(10)      ,/* 資料所屬部門 */
dzddcrtid       varchar2(20)      ,/* 資料建立者 */
dzddcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzddcrtdt       timestamp(0)      ,/* 資料創建日 */
dzddmodid       varchar2(20)      ,/* 資料修改者 */
dzddmoddt       timestamp(0)      ,/* 最近修改日 */
dzddcnfid       varchar2(20)      ,/* 資料確認者 */
dzddcnfdt       timestamp(0)      ,/* 資料確認日 */
dzdd006       varchar2(40)      ,/* 客戶代號 */
dzdd007       varchar2(1)      /* 前置後置flag */
);
alter table dzdd_t add constraint dzdd_pk primary key (dzdd001,dzdd002,dzdd003,dzdd005,dzdd007) enable validate;

create unique index dzdd_pk on dzdd_t (dzdd001,dzdd002,dzdd003,dzdd005,dzdd007);

grant select on dzdd_t to tiptop;
grant update on dzdd_t to tiptop;
grant delete on dzdd_t to tiptop;
grant insert on dzdd_t to tiptop;

exit;
