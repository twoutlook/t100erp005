/* 
================================================================================
檔案代號:pmaml_t
檔案名稱:採購取價方式單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pmaml_t
(
pmamlent       number(5)      ,/* 企業編號 */
pmaml001       varchar2(10)      ,/* 取價方式編號 */
pmaml002       varchar2(6)      ,/* 語言別 */
pmaml003       varchar2(500)      ,/* 說明 */
pmaml004       varchar2(10)      /* 助記碼 */
);
alter table pmaml_t add constraint pmaml_pk primary key (pmamlent,pmaml001,pmaml002) enable validate;

create unique index pmaml_pk on pmaml_t (pmamlent,pmaml001,pmaml002);

grant select on pmaml_t to tiptop;
grant update on pmaml_t to tiptop;
grant delete on pmaml_t to tiptop;
grant insert on pmaml_t to tiptop;

exit;
