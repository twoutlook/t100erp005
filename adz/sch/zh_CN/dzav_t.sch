/* 
================================================================================
檔案代號:dzav_t
檔案名稱:刪除設計資料紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzav_t
(
dzav001       varchar2(20)      ,/* 程式代號 */
dzav002       varchar2(10)      ,/* 模組 */
dzav003       varchar2(1)      ,/* 刪除類型 */
dzav004       number(10)      ,/* 建構版次 */
dzav005       number(10)      ,/* 規格版次 */
dzav006       number(10)      ,/* 程式版次 */
dzavownid       varchar2(20)      ,/* 資料所有者 */
dzavowndp       varchar2(10)      ,/* 資料所屬部門 */
dzavcrtid       varchar2(20)      ,/* 資料建立者 */
dzavcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzavcrtdt       timestamp(0)      ,/* 資料創建日 */
dzavmodid       varchar2(20)      ,/* 資料修改者 */
dzavmoddt       timestamp(0)      /* 最近修改日 */
);
alter table dzav_t add constraint dzav_pk primary key (dzav001) enable validate;

create unique index dzav_pk on dzav_t (dzav001);

grant select on dzav_t to tiptop;
grant update on dzav_t to tiptop;
grant delete on dzav_t to tiptop;
grant insert on dzav_t to tiptop;

exit;
