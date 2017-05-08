/* 
================================================================================
檔案代號:dzfo_t
檔案名稱:畫面樣板元件屬性資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfo_t
(
dzfo001       varchar2(40)      ,/* 結構代號 */
dzfo002       varchar2(10)      ,/* (產品)版號 */
dzfo003       varchar2(40)      ,/* 元件代碼 */
dzfo004       number(5,0)      ,/* 順序 */
dzfo005       varchar2(40)      ,/* 屬性 */
dzfo006       varchar2(40)      /* 屬性值 */
);
alter table dzfo_t add constraint dzfo_pk primary key (dzfo001,dzfo002,dzfo003,dzfo004) enable validate;

create unique index dzfo_pk on dzfo_t (dzfo001,dzfo002,dzfo003,dzfo004);

grant select on dzfo_t to tiptop;
grant update on dzfo_t to tiptop;
grant delete on dzfo_t to tiptop;
grant insert on dzfo_t to tiptop;

exit;
