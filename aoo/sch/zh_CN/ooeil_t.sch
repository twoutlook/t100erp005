/* 
================================================================================
檔案代號:ooeil_t
檔案名稱:組織分群基本檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table ooeil_t
(
ooeilent       number(5)      ,/* 企業編號 */
ooeil001       varchar2(10)      ,/* 組織分群編號 */
ooeil002       varchar2(6)      ,/* 語言別 */
ooeil003       varchar2(500)      ,/* 說明 */
ooeil004       varchar2(10)      /* 助記碼 */
);
alter table ooeil_t add constraint ooeil_pk primary key (ooeilent,ooeil001,ooeil002) enable validate;

create unique index ooeil_pk on ooeil_t (ooeilent,ooeil001,ooeil002);

grant select on ooeil_t to tiptop;
grant update on ooeil_t to tiptop;
grant delete on ooeil_t to tiptop;
grant insert on ooeil_t to tiptop;

exit;
