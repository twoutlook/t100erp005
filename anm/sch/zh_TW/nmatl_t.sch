/* 
================================================================================
檔案代號:nmatl_t
檔案名稱:網銀資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table nmatl_t
(
nmatlent       number(5)      ,/* 企業編碼 */
nmatl001       varchar2(15)      ,/* 網銀編碼 */
nmatl002       varchar2(10)      ,/* 支付狀態編碼 */
nmatl003       varchar2(6)      ,/* 語言別 */
nmatl004       varchar2(500)      ,/* 支付狀態說明 */
nmatl005       varchar2(10)      /* 助記碼 */
);
alter table nmatl_t add constraint nmatl_pk primary key (nmatlent,nmatl001,nmatl002,nmatl003) enable validate;

create unique index nmatl_pk on nmatl_t (nmatlent,nmatl001,nmatl002,nmatl003);

grant select on nmatl_t to tiptop;
grant update on nmatl_t to tiptop;
grant delete on nmatl_t to tiptop;
grant insert on nmatl_t to tiptop;

exit;
