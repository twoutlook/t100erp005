/* 
================================================================================
檔案代號:fmal_t
檔案名稱:融資付息還本設置檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fmal_t
(
fmalent       number(5)      ,/* 企業代碼 */
fmal001       varchar2(10)      ,/* 融資合同編號 */
fmal002       varchar2(1)      ,/* 還款性質 */
fmal003       varchar2(1)      ,/* 還款週期 */
fmal004       number(5,0)      ,/* 起始付息期別 */
fmal005       number(5,0)      ,/* 付息日 */
fmal006       date      ,/* 約定還款日期 */
fmal007       number(20,6)      ,/* 還本金額 */
fmal008       number(10,0)      /* 項次 */
);
alter table fmal_t add constraint fmal_pk primary key (fmalent,fmal001,fmal002,fmal005,fmal006,fmal008) enable validate;

create unique index fmal_pk on fmal_t (fmalent,fmal001,fmal002,fmal005,fmal006,fmal008);

grant select on fmal_t to tiptop;
grant update on fmal_t to tiptop;
grant delete on fmal_t to tiptop;
grant insert on fmal_t to tiptop;

exit;
