/* 
================================================================================
檔案代號:fmmel_t
檔案名稱:交易市場檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table fmmel_t
(
fmmelent       number(5)      ,/* 企業編號 */
fmmel001       varchar2(10)      ,/* 交易市場編號 */
fmmel002       varchar2(6)      ,/* 語言別 */
fmmel003       varchar2(500)      ,/* 說明 */
fmmel004       varchar2(10)      /* 助記碼 */
);
alter table fmmel_t add constraint fmmel_pk primary key (fmmelent,fmmel001,fmmel002) enable validate;

create unique index fmmel_pk on fmmel_t (fmmelent,fmmel001,fmmel002);

grant select on fmmel_t to tiptop;
grant update on fmmel_t to tiptop;
grant delete on fmmel_t to tiptop;
grant insert on fmmel_t to tiptop;

exit;
