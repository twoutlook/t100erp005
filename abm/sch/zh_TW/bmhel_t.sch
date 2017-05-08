/* 
================================================================================
檔案代號:bmhel_t
檔案名稱:料件承認模板單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bmhel_t
(
bmhelent       number(5)      ,/* 企業代碼 */
bmhel001       varchar2(10)      ,/* 模板代號 */
bmhel002       varchar2(6)      ,/* 語言別 */
bmhel003       varchar2(500)      ,/* 說明 */
bmhel004       varchar2(10)      /* 助記碼 */
);
alter table bmhel_t add constraint bmhel_pk primary key (bmhelent,bmhel001,bmhel002) enable validate;

create unique index bmhel_pk on bmhel_t (bmhelent,bmhel001,bmhel002);

grant select on bmhel_t to tiptop;
grant update on bmhel_t to tiptop;
grant delete on bmhel_t to tiptop;
grant insert on bmhel_t to tiptop;

exit;
