/* 
================================================================================
檔案代號:dzay_t
檔案名稱:dzay_t(dzax_t的暫存表:取消簽出使用)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzay_t
(
dzay001       varchar2(20)      ,/* 程式編號 */
dzay002       varchar2(10)      ,/* 程式樣版 */
dzay003       varchar2(1)      ,/* 是否為Free Style */
dzay004       number(5,0)      ,/* 保留參數個數 */
dzay005       varchar2(1)      /* 程式是否需要重產 */
);
alter table dzay_t add constraint dzay_pk primary key (dzay001) enable validate;

create unique index dzay_pk on dzay_t (dzay001);

grant select on dzay_t to tiptop;
grant update on dzay_t to tiptop;
grant delete on dzay_t to tiptop;
grant insert on dzay_t to tiptop;

exit;
