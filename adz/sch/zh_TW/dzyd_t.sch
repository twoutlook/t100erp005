/* 
================================================================================
檔案代號:dzyd_t
檔案名稱:patch設計資料執行結果記錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzyd_t
(
dzyd001       varchar2(80)      ,/* patch序號 */
dzyd002       varchar2(20)      ,/* 程式代碼 */
dzyd003       varchar2(1)      ,/* 規格類別 */
dzyd004       varchar2(255)      ,/* 已執行項目 */
dzyd005       varchar2(4)      ,/* 模組 */
dzyd006       varchar2(80)      ,/* 狀態 */
dzyd007       varchar2(80)      ,/* 錯誤訊息(簡單) */
dzyd008       varchar2(20)      ,/* PID */
dzyd009       number(10)      ,/* 建構版次 */
dzyd010       number(10)      ,/* 規格版次 */
dzyd011       number(10)      ,/* 程式版次 */
dzyd012       varchar2(1)      ,/* 識別標示 */
dzyd013       number(5,0)      ,/* 順序 */
dzyd014       varchar2(1)      ,/* 客製否 */
dzyd015       varchar2(1)      ,/* merge否 */
dzyd016       varchar2(80)      ,/* 執行階段 */
dzyd017       varchar2(40)      ,/* 執行日期 */
dzyd018       varchar2(4000)      /* 錯誤訊息(完整) */
);
alter table dzyd_t add constraint dzyd_pk primary key (dzyd001,dzyd002) enable validate;

create unique index dzyd_pk on dzyd_t (dzyd001,dzyd002);

grant select on dzyd_t to tiptop;
grant update on dzyd_t to tiptop;
grant delete on dzyd_t to tiptop;
grant insert on dzyd_t to tiptop;

exit;
