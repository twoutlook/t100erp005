/* 
================================================================================
檔案代號:dzfb_t
檔案名稱:欄位設計定義資訊
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfb_t
(
dzfb001       varchar2(20)      ,/* 結構代號 */
dzfb002       number(10)      ,/* 規格版次 */
dzfb003       varchar2(40)      ,/* 所屬結構樣式 */
dzfb004       varchar2(40)      ,/* 所屬容器代碼 */
dzfb005       varchar2(40)      ,/* 元件代碼 */
dzfb006       varchar2(40)      ,/* 4gl變數名稱 */
dzfb007       varchar2(1)      ,/* 客製 */
dzfb008       varchar2(40)      /* 客戶代號 */
);
alter table dzfb_t add constraint dzfb_pk primary key (dzfb001,dzfb002,dzfb005,dzfb007) enable validate;

create unique index dzfb_pk on dzfb_t (dzfb001,dzfb002,dzfb005,dzfb007);

grant select on dzfb_t to tiptop;
grant update on dzfb_t to tiptop;
grant delete on dzfb_t to tiptop;
grant insert on dzfb_t to tiptop;

exit;
