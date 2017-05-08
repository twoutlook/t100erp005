/* 
================================================================================
檔案代號:dzfl_t
檔案名稱:畫面元件資料項目檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfl_t
(
dzfl001       varchar2(20)      ,/* 結構代號 */
dzfl002       number(10)      ,/* 規格版次 */
dzfl003       varchar2(40)      ,/* 元件代碼 */
dzfl004       number(5,0)      ,/* 順序 */
dzfl005       varchar2(40)      ,/* 項目name */
dzfl006       varchar2(40)      ,/* 項目text */
dzfl007       varchar2(1)      ,/* 客製 */
dzfl008       varchar2(40)      ,/* 客戶代號 */
dzflstus       varchar2(10)      /* 狀態碼 */
);
alter table dzfl_t add constraint dzfl_pk primary key (dzfl001,dzfl002,dzfl003,dzfl004,dzfl007) enable validate;

create unique index dzfl_pk on dzfl_t (dzfl001,dzfl002,dzfl003,dzfl004,dzfl007);

grant select on dzfl_t to tiptop;
grant update on dzfl_t to tiptop;
grant delete on dzfl_t to tiptop;
grant insert on dzfl_t to tiptop;

exit;
