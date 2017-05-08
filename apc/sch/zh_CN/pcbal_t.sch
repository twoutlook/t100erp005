/* 
================================================================================
檔案代號:pcbal_t
檔案名稱:觸屏分類基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pcbal_t
(
pcbalent       number(5)      ,/* 企業編號 */
pcbal001       varchar2(10)      ,/* 觸屏分類編號 */
pcbal002       varchar2(6)      ,/* 語言別 */
pcbal003       varchar2(500)      ,/* 說明 */
pcbal004       varchar2(10)      /* 助記碼 */
);
alter table pcbal_t add constraint pcbal_pk primary key (pcbalent,pcbal001,pcbal002) enable validate;

create unique index pcbal_pk on pcbal_t (pcbalent,pcbal001,pcbal002);

grant select on pcbal_t to tiptop;
grant update on pcbal_t to tiptop;
grant delete on pcbal_t to tiptop;
grant insert on pcbal_t to tiptop;

exit;
