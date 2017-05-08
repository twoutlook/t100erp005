/* 
================================================================================
檔案代號:nmbdl_t
檔案名稱:資金收支項目資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table nmbdl_t
(
nmbdlent       number(5)      ,/* 企業編號 */
nmbdl001       varchar2(10)      ,/* 版本 */
nmbdl002       varchar2(10)      ,/* 收支項目代碼 */
nmbdl003       varchar2(6)      ,/* 語言別 */
nmbdl004       varchar2(500)      /* 項目說明 */
);
alter table nmbdl_t add constraint nmbdl_pk primary key (nmbdlent,nmbdl001,nmbdl002,nmbdl003) enable validate;

create unique index nmbdl_pk on nmbdl_t (nmbdlent,nmbdl001,nmbdl002,nmbdl003);

grant select on nmbdl_t to tiptop;
grant update on nmbdl_t to tiptop;
grant delete on nmbdl_t to tiptop;
grant insert on nmbdl_t to tiptop;

exit;
