/* 
================================================================================
檔案代號:fmmcl_t
檔案名稱:投資費用類型檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table fmmcl_t
(
fmmclent       number(5)      ,/* 企業代碼 */
fmmcl001       varchar2(10)      ,/* 投資費用類型 */
fmmcl002       varchar2(6)      ,/* 語言別 */
fmmcl003       varchar2(500)      ,/* 說明 */
fmmcl004       varchar2(10)      /* 助記碼 */
);
alter table fmmcl_t add constraint fmmcl_pk primary key (fmmclent,fmmcl001,fmmcl002) enable validate;

create unique index fmmcl_pk on fmmcl_t (fmmclent,fmmcl001,fmmcl002);

grant select on fmmcl_t to tiptop;
grant update on fmmcl_t to tiptop;
grant delete on fmmcl_t to tiptop;
grant insert on fmmcl_t to tiptop;

exit;
