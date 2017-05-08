/* 
================================================================================
檔案代號:dzfp_t
檔案名稱:畫面樣板元件資料項目檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfp_t
(
dzfp001       varchar2(40)      ,/* 結構代號 */
dzfp002       varchar2(10)      ,/* (產品)版號 */
dzfp003       varchar2(40)      ,/* 元件代碼 */
dzfp004       number(5,0)      ,/* 順序 */
dzfp005       varchar2(40)      ,/* 項目name */
dzfp006       varchar2(40)      /* 項目text */
);
alter table dzfp_t add constraint dzfp_pk primary key (dzfp001,dzfp002,dzfp003,dzfp004) enable validate;

create unique index dzfp_pk on dzfp_t (dzfp001,dzfp002,dzfp003,dzfp004);

grant select on dzfp_t to tiptop;
grant update on dzfp_t to tiptop;
grant delete on dzfp_t to tiptop;
grant insert on dzfp_t to tiptop;

exit;
