/* 
================================================================================
檔案代號:inayl_t
檔案名稱:集團庫位基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table inayl_t
(
inaylent       number(5)      ,/* 企業代碼 */
inayl001       varchar2(10)      ,/* 庫位名稱 */
inayl002       varchar2(6)      ,/* 語言別 */
inayl003       varchar2(500)      ,/* 說明 */
inayl004       varchar2(10)      /* 助記碼 */
);
alter table inayl_t add constraint inayl_pk primary key (inaylent,inayl001,inayl002) enable validate;

create unique index inayl_pk on inayl_t (inaylent,inayl001,inayl002);

grant select on inayl_t to tiptop;
grant update on inayl_t to tiptop;
grant delete on inayl_t to tiptop;
grant insert on inayl_t to tiptop;

exit;
