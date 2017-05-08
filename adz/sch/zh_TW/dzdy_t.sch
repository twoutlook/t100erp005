/* 
================================================================================
檔案代號:dzdy_t
檔案名稱:樣板基本資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzdy_t
(
dzdyownid       varchar2(20)      ,/* 資料所有者 */
dzdyowndp       varchar2(10)      ,/* 資料所屬部門 */
dzdycrtid       varchar2(20)      ,/* 資料建立者 */
dzdycrtdp       varchar2(10)      ,/* 資料建立部門 */
dzdycrtdt       timestamp(0)      ,/* 資料創建日 */
dzdymodid       varchar2(20)      ,/* 資料修改者 */
dzdymoddt       timestamp(0)      ,/* 最近修改日 */
dzdystus       varchar2(10)      ,/* 狀態碼 */
dzdy001       varchar2(20)      ,/* 樣板編號 */
dzdy002       varchar2(1)      ,/* 樣板類型 */
dzdy003       varchar2(80)      ,/* 樣板功能說明 */
dzdy004       varchar2(80)      ,/* 樣板存放路徑 */
dzdy005       varchar2(20)      /* 參考範例程式 */
);
alter table dzdy_t add constraint dzdy_pk primary key (dzdy001) enable validate;

create unique index dzdy_pk on dzdy_t (dzdy001);

grant select on dzdy_t to tiptop;
grant update on dzdy_t to tiptop;
grant delete on dzdy_t to tiptop;
grant insert on dzdy_t to tiptop;

exit;
