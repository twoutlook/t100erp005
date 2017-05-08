/* 
================================================================================
檔案代號:dzfn_t
檔案名稱:畫面樣板元件組合檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfn_t
(
dzfn001       varchar2(40)      ,/* 結構代號 */
dzfn002       varchar2(10)      ,/* (產品)版號 */
dzfn003       varchar2(40)      ,/* 元件組代碼 */
dzfn004       number(5,0)      ,/* 順序 */
dzfn005       varchar2(40)      ,/* 包含元件代碼 */
dzfn006       varchar2(20)      /* 節點類型 */
);
alter table dzfn_t add constraint dzfn_pk primary key (dzfn001,dzfn002,dzfn003,dzfn004) enable validate;

create unique index dzfn_pk on dzfn_t (dzfn001,dzfn002,dzfn003,dzfn004);

grant select on dzfn_t to tiptop;
grant update on dzfn_t to tiptop;
grant delete on dzfn_t to tiptop;
grant insert on dzfn_t to tiptop;

exit;
