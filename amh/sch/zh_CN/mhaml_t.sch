/* 
================================================================================
檔案代號:mhaml_t
檔案名稱:電器基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table mhaml_t
(
mhamlent       number(5)      ,/* 企業編號 */
mhaml001       varchar2(20)      ,/* 電器編號 */
mhaml002       varchar2(6)      ,/* 語言別 */
mhaml003       varchar2(500)      ,/* 說明 */
mhaml004       varchar2(10)      /* 助記碼 */
);
alter table mhaml_t add constraint mhaml_pk primary key (mhamlent,mhaml001,mhaml002) enable validate;

create unique index mhaml_pk on mhaml_t (mhamlent,mhaml001,mhaml002);

grant select on mhaml_t to tiptop;
grant update on mhaml_t to tiptop;
grant delete on mhaml_t to tiptop;
grant insert on mhaml_t to tiptop;

exit;
