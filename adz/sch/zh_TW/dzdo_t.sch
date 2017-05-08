/* 
================================================================================
檔案代號:dzdo_t
檔案名稱:元件規格設計表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzdo_t
(
dzdo001       varchar2(40)      ,/* 元件代號 */
dzdo002       number(10)      ,/* 識別碼版次 */
dzdo003       varchar2(1)      ,/* 使用標示 */
dzdo099       clob      ,/* 規格描述 */
dzdoownid       varchar2(20)      ,/* 資料所有者 */
dzdoowndp       varchar2(10)      ,/* 資料所屬部門 */
dzdocrtid       varchar2(20)      ,/* 資料建立者 */
dzdocrtdp       varchar2(10)      ,/* 資料建立部門 */
dzdocrtdt       timestamp(0)      ,/* 資料創建日 */
dzdomodid       varchar2(20)      ,/* 資料修改者 */
dzdomoddt       timestamp(0)      ,/* 最近修改日 */
dzdostus       varchar2(10)      ,/* 狀態碼 */
dzdo004       varchar2(40)      /* 客戶代號 */
);
alter table dzdo_t add constraint dzdo_pk primary key (dzdo001,dzdo002,dzdo003) enable validate;

create unique index dzdo_pk on dzdo_t (dzdo001,dzdo002,dzdo003);

grant select on dzdo_t to tiptop;
grant update on dzdo_t to tiptop;
grant delete on dzdo_t to tiptop;
grant insert on dzdo_t to tiptop;

exit;
