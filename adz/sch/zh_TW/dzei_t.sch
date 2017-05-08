/* 
================================================================================
檔案代號:dzei_t
檔案名稱:共通代碼主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzei_t
(
dzeistus       varchar2(10)      ,/* 狀態碼 */
dzei001       varchar2(40)      ,/* 代碼代號 */
dzei002       varchar2(80)      ,/* 代碼名稱 */
dzei003       varchar2(15)      ,/* 模組代號 */
dzei004       varchar2(255)      ,/* 用途描述 */
dzeiownid       varchar2(20)      ,/* 資料所有者 */
dzeiowndp       varchar2(10)      ,/* 資料所屬部門 */
dzeicrtid       varchar2(20)      ,/* 資料建立者 */
dzeicrtdp       varchar2(10)      ,/* 資料建立部門 */
dzeicrtdt       timestamp(0)      ,/* 資料創建日 */
dzeimodid       varchar2(20)      ,/* 資料修改者 */
dzeimoddt       timestamp(0)      ,/* 最近修改日 */
dzeicnfid       varchar2(20)      ,/* 資料確認者 */
dzeicnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzei_t add constraint dzei_pk primary key (dzei001) enable validate;

create unique index dzei_pk on dzei_t (dzei001);

grant select on dzei_t to tiptop;
grant update on dzei_t to tiptop;
grant delete on dzei_t to tiptop;
grant insert on dzei_t to tiptop;

exit;
