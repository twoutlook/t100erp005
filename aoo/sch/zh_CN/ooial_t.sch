/* 
================================================================================
檔案代號:ooial_t
檔案名稱:款別主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table ooial_t
(
ooialent       number(5)      ,/* 企業編號 */
ooial001       varchar2(10)      ,/* 款別編號 */
ooial002       varchar2(6)      ,/* 語言別 */
ooial003       varchar2(500)      ,/* 說明 */
ooial004       varchar2(10)      /* 助記碼 */
);
alter table ooial_t add constraint ooial_pk primary key (ooialent,ooial001,ooial002) enable validate;

create unique index ooial_pk on ooial_t (ooialent,ooial001,ooial002);

grant select on ooial_t to tiptop;
grant update on ooial_t to tiptop;
grant delete on ooial_t to tiptop;
grant insert on ooial_t to tiptop;

exit;
