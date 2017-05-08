/* 
================================================================================
檔案代號:dzft_t
檔案名稱:行業畫面未引用標準UI元件檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzft_t
(
dzft001       varchar2(20)      ,/* 畫面代碼 */
dzft002       varchar2(40)      ,/* 未引用UI代碼 */
dzft003       varchar2(1)      ,/* 客製 */
dzft004       varchar2(1)      ,/* UI元件類型 */
dzft005       number(10)      ,/* 失效版次 */
dzft006       varchar2(40)      ,/* 失效項目name */
dzftownid       varchar2(20)      ,/* 資料所有者 */
dzftowndp       varchar2(10)      ,/* 資料所屬部門 */
dzftcrtid       varchar2(20)      ,/* 資料建立者 */
dzftcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzftcrtdt       timestamp(0)      ,/* 資料創建日 */
dzftmodid       varchar2(20)      ,/* 資料修改者 */
dzftmoddt       timestamp(0)      /* 最近修改日 */
);
alter table dzft_t add constraint dzft_pk primary key (dzft001,dzft002,dzft003,dzft006) enable validate;

create unique index dzft_pk on dzft_t (dzft001,dzft002,dzft003,dzft006);

grant select on dzft_t to tiptop;
grant update on dzft_t to tiptop;
grant delete on dzft_t to tiptop;
grant insert on dzft_t to tiptop;

exit;
