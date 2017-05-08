/* 
================================================================================
檔案代號:rtaas_t
檔案名稱:店群基本資料檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table rtaas_t
(
rtaasent       number(5)      ,/* 企業代碼 */
rtaas001       varchar2(10)      ,/* 店群編號 */
rtaas002       varchar2(40)      ,/* 提速值 */
rtaas003       number(5,0)      /* 階層 */
);
alter table rtaas_t add constraint rtaas_pk primary key (rtaasent,rtaas001,rtaas002) enable validate;


grant select on rtaas_t to tiptop;
grant update on rtaas_t to tiptop;
grant delete on rtaas_t to tiptop;
grant insert on rtaas_t to tiptop;

exit;
