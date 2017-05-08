/* 
================================================================================
檔案代號:ooibl_t
檔案名稱:收付款條件主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table ooibl_t
(
ooiblent       number(5)      ,/* 企業編號 */
ooibl002       varchar2(10)      ,/* 收付款條件編號 */
ooibl003       varchar2(6)      ,/* 語言別 */
ooibl004       varchar2(500)      ,/* 說明 */
ooibl005       varchar2(10)      /* 助記碼 */
);
alter table ooibl_t add constraint ooibl_pk primary key (ooiblent,ooibl002,ooibl003) enable validate;

create unique index ooibl_pk on ooibl_t (ooiblent,ooibl002,ooibl003);

grant select on ooibl_t to tiptop;
grant update on ooibl_t to tiptop;
grant delete on ooibl_t to tiptop;
grant insert on ooibl_t to tiptop;

exit;
