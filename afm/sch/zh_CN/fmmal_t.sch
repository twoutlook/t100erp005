/* 
================================================================================
檔案代號:fmmal_t
檔案名稱:投資類型檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table fmmal_t
(
fmmalent       number(5)      ,/* 企業編號 */
fmmal001       varchar2(10)      ,/* 投資類型 */
fmmal002       varchar2(6)      ,/* 語言別 */
fmmal003       varchar2(500)      ,/* 說明 */
fmmal004       varchar2(10)      /* 助記碼 */
);
alter table fmmal_t add constraint fmmal_pk primary key (fmmalent,fmmal001,fmmal002) enable validate;

create unique index fmmal_pk on fmmal_t (fmmalent,fmmal001,fmmal002);

grant select on fmmal_t to tiptop;
grant update on fmmal_t to tiptop;
grant delete on fmmal_t to tiptop;
grant insert on fmmal_t to tiptop;

exit;
