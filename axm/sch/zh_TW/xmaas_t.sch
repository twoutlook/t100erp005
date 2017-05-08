/* 
================================================================================
檔案代號:xmaas_t
檔案名稱:品類基本資料檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table xmaas_t
(
xmaasent       number(5)      ,/* 企業代碼 */
xmaas001       varchar2(10)      ,/* 品類編號 */
xmaas002       varchar2(40)      ,/* 提速值 */
xmaas003       number(5,0)      /* 階層 */
);
alter table xmaas_t add constraint xmaas_pk primary key (xmaasent,xmaas001,xmaas002) enable validate;


grant select on xmaas_t to tiptop;
grant update on xmaas_t to tiptop;
grant delete on xmaas_t to tiptop;
grant insert on xmaas_t to tiptop;

exit;
