/* 
================================================================================
檔案代號:dzeo_t
檔案名稱:表格版本控制碼檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzeo_t
(
dzeo001       varchar2(40)      ,/* 物件代號 */
dzeo002       number(5,0)      ,/* 大版本號 */
dzeo003       number(5,0)      ,/* 中版本號 */
dzeo004       number(5,0)      ,/* 小版本號 */
dzeo005       number(22,2)      ,/* 編譯或測試號 */
dzeo006       varchar2(1)      ,/* 擴充欄位 */
dzeo007       varchar2(1)      ,/* 擴充欄位 */
dzeo008       varchar2(1)      ,/* 擴充欄位 */
dzeo009       varchar2(1)      ,/* 擴充欄位 */
dzeoownid       varchar2(20)      ,/* 資料所有者 */
dzeoowndp       varchar2(10)      ,/* 資料所屬部門 */
dzeocrtid       varchar2(20)      ,/* 資料建立者 */
dzeocrtdp       varchar2(10)      ,/* 資料建立部門 */
dzeocrtdt       timestamp(0)      ,/* 資料創建日 */
dzeomodid       varchar2(20)      ,/* 資料修改者 */
dzeomoddt       timestamp(0)      ,/* 最近修改日 */
dzeocnfid       varchar2(20)      ,/* 資料確認者 */
dzeocnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzeo_t add constraint dzeo_pk primary key (dzeo001) enable validate;

create unique index dzeo_pk on dzeo_t (dzeo001);

grant select on dzeo_t to tiptop;
grant update on dzeo_t to tiptop;
grant delete on dzeo_t to tiptop;
grant insert on dzeo_t to tiptop;

exit;
