/* 
================================================================================
檔案代號:nmanl_t
檔案名稱:網銀資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table nmanl_t
(
nmanlent       number(5)      ,/* 企業編碼 */
nmanl001       varchar2(15)      ,/* 網銀編碼 */
nmanl002       varchar2(6)      ,/* 語言別 */
nmanl003       varchar2(500)      ,/* 說明 */
nmanl004       varchar2(10)      /* 助記碼 */
);
alter table nmanl_t add constraint nmanl_pk primary key (nmanlent,nmanl001,nmanl002) enable validate;

create unique index nmanl_pk on nmanl_t (nmanlent,nmanl001,nmanl002);

grant select on nmanl_t to tiptop;
grant update on nmanl_t to tiptop;
grant delete on nmanl_t to tiptop;
grant insert on nmanl_t to tiptop;

exit;
