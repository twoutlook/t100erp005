/* 
================================================================================
檔案代號:dzfk_t
檔案名稱:畫面元件屬性資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfk_t
(
dzfk001       varchar2(20)      ,/* 結構代號 */
dzfk002       number(10)      ,/* 規格版次 */
dzfk003       varchar2(40)      ,/* 元件代碼 */
dzfk004       number(5,0)      ,/* no use */
dzfk005       varchar2(40)      ,/* no use */
dzfk006       varchar2(40)      ,/* no use */
dzfk007       varchar2(1)      ,/* 客製 */
dzfk008       varchar2(40)      ,/* 客戶代號 */
dzfk009       clob      /* 屬性值 */
);
alter table dzfk_t add constraint dzfk_pk primary key (dzfk001,dzfk002,dzfk003,dzfk007) enable validate;

create unique index dzfk_pk on dzfk_t (dzfk001,dzfk002,dzfk003,dzfk007);

grant select on dzfk_t to tiptop;
grant update on dzfk_t to tiptop;
grant delete on dzfk_t to tiptop;
grant insert on dzfk_t to tiptop;

exit;
