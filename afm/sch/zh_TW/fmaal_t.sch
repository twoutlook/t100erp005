/* 
================================================================================
檔案代號:fmaal_t
檔案名稱:融資類型檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table fmaal_t
(
fmaalent       number(5)      ,/* 企業編號 */
fmaal001       varchar2(10)      ,/* 融資類型 */
fmaal002       varchar2(6)      ,/* 語言別 */
fmaal003       varchar2(500)      ,/* 說明 */
fmaal004       varchar2(10)      /* 助記碼 */
);
alter table fmaal_t add constraint fmaal_pk primary key (fmaalent,fmaal001,fmaal002) enable validate;

create unique index fmaal_pk on fmaal_t (fmaalent,fmaal001,fmaal002);

grant select on fmaal_t to tiptop;
grant update on fmaal_t to tiptop;
grant delete on fmaal_t to tiptop;
grant insert on fmaal_t to tiptop;

exit;
