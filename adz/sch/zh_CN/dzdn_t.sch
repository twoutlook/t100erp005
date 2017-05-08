/* 
================================================================================
檔案代號:dzdn_t
檔案名稱:元件與元素版次對應表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzdn_t
(
dzdn001       varchar2(40)      ,/* 元件代號 */
dzdn002       number(10)      ,/* 元件版次 */
dzdn003       varchar2(60)      ,/* 識別碼 */
dzdn004       number(10)      ,/* 識別碼版次 */
dzdn005       varchar2(1)      ,/* 使用標示 */
dzdn006       varchar2(40)      ,/* 客戶代號 */
dzdnownid       varchar2(20)      ,/* 資料所有者 */
dzdnowndp       varchar2(10)      ,/* 資料所屬部門 */
dzdncrtid       varchar2(20)      ,/* 資料建立者 */
dzdncrtdp       varchar2(10)      ,/* 資料建立部門 */
dzdncrtdt       timestamp(0)      ,/* 資料創建日 */
dzdnmodid       varchar2(20)      ,/* 資料修改者 */
dzdnmoddt       timestamp(0)      ,/* 最近修改日 */
dzdnstus       varchar2(10)      ,/* 狀態碼 */
dzdn007       varchar2(1)      /* 識別標示 */
);
alter table dzdn_t add constraint dzdn_pk primary key (dzdn001,dzdn002,dzdn003) enable validate;

create unique index dzdn_pk on dzdn_t (dzdn001,dzdn002,dzdn003);

grant select on dzdn_t to tiptop;
grant update on dzdn_t to tiptop;
grant delete on dzdn_t to tiptop;
grant insert on dzdn_t to tiptop;

exit;
