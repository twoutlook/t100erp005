/* 
================================================================================
檔案代號:dzgj_t
檔案名稱:報表元件設計-參數明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzgj_t
(
dzgj001       varchar2(20)      ,/* 報表元件代號 */
dzgj002       number(10)      ,/* 版次 */
dzgj003       number(10,0)      ,/* 序號 */
dzgj004       varchar2(60)      ,/* 參數代號 */
dzgj005       varchar2(20)      ,/* 參數型態參考欄位\String */
dzgj006       varchar2(80)      ,/* 參數說明 */
dzgj007       varchar2(40)      ,/* 客戶代號 */
dzgj008       varchar2(1)      /* 客製 */
);
alter table dzgj_t add constraint dzgj_pk primary key (dzgj001,dzgj002,dzgj003,dzgj008) enable validate;

create unique index dzgj_pk on dzgj_t (dzgj001,dzgj002,dzgj003,dzgj008);

grant select on dzgj_t to tiptop;
grant update on dzgj_t to tiptop;
grant delete on dzgj_t to tiptop;
grant insert on dzgj_t to tiptop;

exit;
