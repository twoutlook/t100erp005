/* 
================================================================================
檔案代號:mraal_t
檔案名稱:保修週期設定檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table mraal_t
(
mraalent       number(5)      ,/* 企業編號 */
mraal001       varchar2(10)      ,/* 保修週期編號 */
mraal002       varchar2(6)      ,/* 語言別 */
mraal003       varchar2(500)      ,/* 說明 */
mraal004       varchar2(10)      /* 助記碼 */
);
alter table mraal_t add constraint mraal_pk primary key (mraalent,mraal001,mraal002) enable validate;

create unique index mraal_pk on mraal_t (mraalent,mraal001,mraal002);

grant select on mraal_t to tiptop;
grant update on mraal_t to tiptop;
grant delete on mraal_t to tiptop;
grant insert on mraal_t to tiptop;

exit;
