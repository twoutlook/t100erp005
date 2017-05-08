/* 
================================================================================
檔案代號:rpzzl_t
檔案名稱:APP基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table rpzzl_t
(
rpzzl001       varchar2(20)      ,/* APP編號 */
rpzzl002       varchar2(6)      ,/* 語言別 */
rpzzl003       varchar2(500)      ,/* 說明 */
rpzzl004       varchar2(10)      /* 助記碼 */
);
alter table rpzzl_t add constraint rpzzl_pk primary key (rpzzl001,rpzzl002) enable validate;

create unique index rpzzl_pk on rpzzl_t (rpzzl001,rpzzl002);

grant select on rpzzl_t to tiptop;
grant update on rpzzl_t to tiptop;
grant delete on rpzzl_t to tiptop;
grant insert on rpzzl_t to tiptop;

exit;
