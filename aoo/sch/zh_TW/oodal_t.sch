/* 
================================================================================
檔案代號:oodal_t
檔案名稱:申報單位多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table oodal_t
(
oodalent       number(5)      ,/* 企業編號 */
oodal001       varchar2(10)      ,/* 稅區別 */
oodal002       varchar2(10)      ,/* 申報單位 */
oodal003       varchar2(6)      ,/* 語言別 */
oodal004       varchar2(500)      ,/* 說明 */
oodal005       varchar2(10)      /* 助記碼 */
);
alter table oodal_t add constraint oodal_pk primary key (oodalent,oodal001,oodal002,oodal003) enable validate;

create  index oodal_01 on oodal_t (oodal005);
create unique index oodal_pk on oodal_t (oodalent,oodal001,oodal002,oodal003);

grant select on oodal_t to tiptop;
grant update on oodal_t to tiptop;
grant delete on oodal_t to tiptop;
grant insert on oodal_t to tiptop;

exit;
