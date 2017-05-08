/* 
================================================================================
檔案代號:rmdc_t
檔案名稱:RMA覆出單多庫儲批明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rmdc_t
(
rmdcent       number(5)      ,/* 企業編號 */
rmdcsite       varchar2(10)      ,/* 營運據點 */
rmdcdocno       varchar2(20)      ,/* 單據單號 */
rmdcseq       number(10,0)      ,/* 項次 */
rmdcseq1       number(10,0)      ,/* 項序 */
rmdc001       varchar2(40)      ,/* 料號 */
rmdc002       varchar2(256)      ,/* 產品特徵 */
rmdc003       varchar2(10)      ,/* 單位 */
rmdc004       number(20,6)      ,/* 數量 */
rmdc005       varchar2(10)      ,/* 庫位 */
rmdc006       varchar2(10)      ,/* 儲位 */
rmdc007       varchar2(30)      ,/* 批號 */
rmdc008       varchar2(30)      /* 庫存特徵 */
);
alter table rmdc_t add constraint rmdc_pk primary key (rmdcent,rmdcdocno,rmdcseq,rmdcseq1) enable validate;

create unique index rmdc_pk on rmdc_t (rmdcent,rmdcdocno,rmdcseq,rmdcseq1);

grant select on rmdc_t to tiptop;
grant update on rmdc_t to tiptop;
grant delete on rmdc_t to tiptop;
grant insert on rmdc_t to tiptop;

exit;
