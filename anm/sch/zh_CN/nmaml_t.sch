/* 
================================================================================
檔案代號:nmaml_t
檔案名稱:資金對帳調節碼多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table nmaml_t
(
nmamlent       number(5)      ,/* 企業編號 */
nmaml001       varchar2(10)      ,/* 資金對帳調節碼表編碼 */
nmaml002       varchar2(10)      ,/* 調節碼 */
nmaml003       varchar2(6)      ,/* 語言別 */
nmaml004       varchar2(500)      /* 說明 */
);
alter table nmaml_t add constraint nmaml_pk primary key (nmamlent,nmaml001,nmaml002,nmaml003) enable validate;

create unique index nmaml_pk on nmaml_t (nmamlent,nmaml001,nmaml002,nmaml003);

grant select on nmaml_t to tiptop;
grant update on nmaml_t to tiptop;
grant delete on nmaml_t to tiptop;
grant insert on nmaml_t to tiptop;

exit;
