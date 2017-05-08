/* 
================================================================================
檔案代號:dzyc_t
檔案名稱:patch資料表參數設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzyc_t
(
dzyc001       varchar2(15)      ,/* 資料表名稱 */
dzyc002       varchar2(1)      ,/* patch動作 */
dzyc003       varchar2(20)      ,/* 客製欄位代號 */
dzyc004       varchar2(500)      ,/* patch條件 */
dzyc005       varchar2(20)      /* 資料多語言欄位代號 */
);
alter table dzyc_t add constraint dzyc_pk primary key (dzyc001) enable validate;

create unique index dzyc_pk on dzyc_t (dzyc001);

grant select on dzyc_t to tiptop;
grant update on dzyc_t to tiptop;
grant delete on dzyc_t to tiptop;
grant insert on dzyc_t to tiptop;

exit;
