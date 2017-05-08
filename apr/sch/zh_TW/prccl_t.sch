/* 
================================================================================
檔案代號:prccl_t
檔案名稱:促銷活動計劃主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table prccl_t
(
prcclent       number(5)      ,/* 企業編號 */
prccl001       varchar2(30)      ,/* 活動計劃 */
prccl002       varchar2(6)      ,/* 語言別 */
prccl003       varchar2(500)      ,/* 說明 */
prccl004       varchar2(10)      /* 助記碼 */
);
alter table prccl_t add constraint prccl_pk primary key (prcclent,prccl001,prccl002) enable validate;


grant select on prccl_t to tiptop;
grant update on prccl_t to tiptop;
grant delete on prccl_t to tiptop;
grant insert on prccl_t to tiptop;

exit;
